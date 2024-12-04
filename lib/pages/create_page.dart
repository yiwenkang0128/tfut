import 'package:flutter/material.dart';
import 'package:i_budget/widgets/category_grid.dart';
import 'package:i_budget/widgets/create_top_bar.dart';
import 'package:i_budget/widgets/input_panel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/category_service.dart';
import '../services/bill_service.dart';

class CreatePage extends StatefulWidget {
  final String? userId;

  const CreatePage({this.userId, super.key});

  @override
  CreatePageState createState() => CreatePageState();
}

class CreatePageState extends State<CreatePage> {
  final CategoryService _categoryService = CategoryService();
  final BillService _billService = BillService();

  String selectedCategory = ''; // Allow selectedCategory to be nullable
  String selectedTab = 'Expense'; // Default selected tab
  List<String> categories = []; // Categories from the database
  double amount = 0.0;
  DateTime selectedDate = DateTime.now();
  String? _userId;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await _loadUserId();
      if (_userId != null) {
        await _loadCategories(selectedTab);
      } else {
        _redirectToLogin();
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Initialization error: $e';
      });
    }
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = widget.userId ?? prefs.getString('userId');
    });
  }

  Future<void> _loadCategories(String tab) async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      if (_userId == null) throw Exception('User ID is null');

      final data = await _categoryService.getCategoriesByUserAndType(
        _userId!,
        tab,
      );

      final defaultCategories = tab == 'Expense'
          ? ['Food', 'Transportation', 'Housing', 'Entertainment']
          : ['Salary', 'Investments', 'Gifts'];

      setState(() {
        categories = data.isNotEmpty ? data : defaultCategories;
        selectedCategory = categories.isNotEmpty ? categories.first : '';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load categories: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _redirectToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _updateCategories(String tab) async {
    setState(() {
      selectedTab = tab;
      _isLoading = true;
    });
    await _loadCategories(tab);
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveBill() async {
    try {
      if (_userId == null) throw Exception('User ID is null');
      if (amount <= 0) throw Exception('Amount must be greater than zero');

      setState(() {
        _isLoading = true;
      });

      await _billService.addBill(
        userId: _userId!,
        category: selectedCategory,
        amount: amount,
        date: selectedDate,
        type: selectedTab,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bill added successfully')),
      );

      Navigator.pushReplacementNamed(
        context,
        '/home',
        arguments: {'userId': _userId},
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to add bill: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopNavigation(
        selectedTab: selectedTab,
        onTabChanged: _updateCategories,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Text(
                    'Error: $_errorMessage',
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: categories.isEmpty
                          ? const Center(
                              child: Text(
                                'No categories available',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            )
                          : CategoryGrid(
                              categories: categories,
                              selectedCategory: selectedCategory,
                              onCategorySelected: (category) {
                                setState(() {
                                  selectedCategory = category;
                                });
                              },
                            ),
                    ),
                    SizedBox(
                      height: 300,
                      child: InputPanel(
                        onSave: () {
                          _saveBill();
                          Navigator.of(context).pop(true);
                        },
                        onAmountChanged: (value) {
                          setState(() {
                            amount = value;
                          });
                        },
                        onDateChanged: (value) {
                          selectedDate = value;
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
