import 'package:flutter/material.dart'; // 引入 material 库

const List<Map<String, dynamic>> testData = [
  {
    'date': '11月30日',
    'netExpense': '-60',
    'expenses': [
      {'category': '学习', 'amount': 300},
      {'category': '宠物', 'amount': 260},
    ],
    'incomes': [
      {'category': '零花钱', 'amount': 500},
    ],
  },
  {
    'date': '11月29日',
    'netExpense': '+640',
    'expenses': [
      {'category': '住房', 'amount': 1000},
      {'category': '娱乐', 'amount': 360},
    ],
    'incomes': [],
  },
  // 如果需要额外数据，可以取消注释并修改日期避免重复
  // {
  //   'date': '11月28日',
  //   'netExpense': '+1640',
  //   'expenses': [
  //     {'category': '购物', 'amount': 200},
  //     {'category': '医疗', 'amount': 140},
  //   ],
  //   'incomes': [
  //     {'category': '工资', 'amount': 2000},
  //   ],
  // },
];

class TestData {
  static final categorizedExpenditure = [
    // 改为 final
    {'type': '饮食', 'amount': 1200.0, 'color': Colors.red},
    {'type': '交通', 'amount': 500.0, 'color': Colors.blue},
    {'type': '娱乐', 'amount': 500.0, 'color': Colors.green},
  ];
}
