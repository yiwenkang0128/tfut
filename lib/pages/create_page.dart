import 'package:flutter/material.dart';
import 'package:i_budget/widgets/category_grid.dart';
import 'package:i_budget/widgets/create_top_bar.dart';
import 'package:i_budget/widgets/input_panel.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  String selectedCategory = '三餐'; // 默认选中的分类
  String selectedTab = '支出'; // 默认选中的标签
  List<String> categories = [
    '三餐',
    '衣服',
    '旅行',
    '宠物',
    '日用品',
    '住房',
    '医疗',
    '娱乐',
    '其他',
  ]; // 默认分类

  void _updateCategories(String tab) {
    setState(() {
      selectedTab = tab;
      if (tab == '支出') {
        categories = [
          '三餐',
          '衣服',
          '旅行',
          '宠物',
          '日用品',
          '住房',
          '医疗',
          '娱乐',
          '其他',
        ];
      } else if (tab == '收入') {
        categories = [
          '转账',
          '工资',
          '退款',
          '礼物',
          '其他',
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
