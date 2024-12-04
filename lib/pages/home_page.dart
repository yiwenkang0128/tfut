import 'package:flutter/material.dart';
import 'package:i_budget/widgets/bill_list.dart';
import 'package:i_budget/widgets/budget_summary.dart';
import 'package:i_budget/widgets/home_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/sidebar_menu.dart';
import '../widgets/year_month_picker.dart';
import '../services/bill_service.dart';
import '../services/budget_service.dart';

class HomePage extends StatefulWidget {
  final String? userId;

  const HomePage({this.userId, super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final BillService _billService = BillService();
  final BudgetService _budgetService = BudgetService();

  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;
  List<Map<String, dynamic>> _bills = [];
  int _totalBudget = 0;
  int _consumed = 0;
  String? _userId;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      await _loadUserId();
      if (_userId != null) {
        await _loadData();
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
      _userId = prefs.getString('userId');
    });
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      if (_userId == null) throw Exception('User ID is null');

      final bills = await _billService.getBillsByDate(
        userId: _userId!,
        year: _selectedYear,
        month: _selectedMonth,
      );

      final totalBudget = await _budgetService.getBudgetForMonth(
        _selectedYear,
        _selectedMonth,
      );
      final transformedBills = _transformBills(bills);

      setState(() {
        _bills = transformedBills;
        _totalBudget = totalBudget ?? 0;
        _consumed = _calculateTotalConsumed(transformedBills).toInt();
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Data loading error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> _transformBills(List<Map<String, dynamic>> bills) {
    final Map<String, Map<String, dynamic>> groupedBills = {};

    for (var bill in bills) {
      final date = bill['date'] as String;
      final type = bill['type'] as String;
      final category = bill['category'] as String;
      final amount = bill['amount'] as num;

      if (!groupedBills.containsKey(date)) {
        groupedBills[date] = {
          'date': date,
          'netExpense': 0,
          'expenses': [],
          'incomes': [],
        };
      }

      final entry = groupedBills[date]!;

      if (type == 'Expense') {
        entry['expenses'].add({'category': category, 'amount': amount});
        entry['netExpense'] -= amount;
      } else if (type == 'Income') {
        entry['incomes'].add({'category': category, 'amount': amount});
        entry['netExpense'] += amount;
      }
    }

    return groupedBills.values.map((e) {
      e['netExpense'] = e['netExpense'] >= 0
          ? '+${e['netExpense'].toStringAsFixed(0)}'
          : e['netExpense'].toStringAsFixed(0);
      return e;
    }).toList();
  }

  double _calculateTotalConsumed(List<Map<String, dynamic>> bills) {
    double total = 0.0;
    for (var bill in bills) {
      final expenses = bill['expenses'] as List;
      for (var expense in expenses) {
        total += expense['amount'];
      }
    }
    return total;
  }

  void _redirectToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _showYearMonthPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            height: 400,
            child: YearMonthPicker(
              selectedYear: _selectedYear,
              selectedMonth: _selectedMonth,
              onYearMonthChanged: (int year, int month) {
                setState(() {
                  _selectedYear = year;
                  _selectedMonth = month;
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  void _onAddButtonPressed() {
    if (_userId == null) {
      debugPrint('User ID is null. Cannot add new item.');
      return;
    }

    Navigator.of(context).pushNamed(
      '/create',
      arguments: {'userId': _userId},
    ).then((result) {
      if (result == true) {
        _loadData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: HomeAppBar(
        scaffoldKey: _scaffoldKey,
        selectedDate: '$_selectedMonth/$_selectedYear',
        onMenuPressed: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        onCalendarTap: _showYearMonthPicker,
      ),
      drawer: SidebarMenu(),
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            BudgetSummary(
              totalBudget: _totalBudget,
              consumed: _consumed,
              remaining: _totalBudget - _consumed,
            ),
            const SizedBox(height: 10.0),
            BillList(
              bills: _bills,
              height: 600.0, 
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 40,
        height: 40,
        child: FloatingActionButton(
          onPressed: _onAddButtonPressed,
          backgroundColor: const Color.fromRGBO(255, 196, 18, 1),
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
    );
  }
}
