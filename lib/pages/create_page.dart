import 'package:flutter/material.dart';
import 'package:i_budget/widgets/category_grid.dart';
import 'package:i_budget/widgets/create_top_bar.dart';
import 'package:i_budget/widgets/input_panel.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  String selectedCategory = 'Meal'; // 默认选中的分类
  String selectedTab = 'Expense'; // 默认选中的标签
  List<String> categories = [
    'Meal',
    'Clothing',
    'Travel',
    'Pet',
    'Daily Necessities',
    'Housing',
    'Medical',
    'Entertainment',
    'Others',
  ]; // 默认分类

  void _updateCategories(String tab) {
    setState(() {
      selectedTab = tab;
      if (tab == 'Expense') {
        categories = [
          'Meal',
          'Clothing',
          'Travel',
          'Pet',
          'Daily Necessities',
          'Housing',
          'Medical',
          'Entertainment',
          'Others',
        ];
      } else if (tab == 'Income') {
        categories = [
          'Transfer',
          'Salary',
          'Refund',
          'Gift',
          'Others',
        ];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopNavigation(
        selectedTab: selectedTab,
        onTabChanged: _updateCategories,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: CategoryGrid(
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
            height: 300, // 固定高度
            child: InputPanel(
              onSave: () {
                Navigator.of(context).pushNamed('/home'); // 保存后跳转到首页
              },
            ),
          ),
        ],
      ),
    );
  }
}
