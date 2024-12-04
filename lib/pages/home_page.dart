import 'package:flutter/material.dart';
import 'package:i_budget/pages/test_data.dart';
import 'package:i_budget/widgets/bill_list.dart';
import 'package:i_budget/widgets/budget_summary.dart';
import 'package:i_budget/widgets/home_app_bar.dart';
import '../widgets/sidebar_menu.dart';
import '../widgets/year_month_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedYear = DateTime.now().year; // 当前年份
  int _selectedMonth = DateTime.now().month; // 当前月份

  // 显示日历选择器
  void _showYearMonthPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white, // 设置Dialog背景颜色为白色
          child: Container(
            padding: EdgeInsets.all(16.0),
            height: 400,
            child: YearMonthPicker(
              selectedYear: _selectedYear,
              selectedMonth: _selectedMonth,
              onYearMonthChanged: (int year, int month) {
                setState(() {
                  _selectedYear = year;
                  _selectedMonth = month;
                });
                Navigator.pop(context); // 关闭弹窗
              },
            ),
          ),
        );
      },
    );
  }

  // 点击加号按钮的事件
  void _onAddButtonPressed() {
    Navigator.of(context).pushNamed('/create'); // 跳转到 /create 页面
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white, // 确保背景颜色为白色
      appBar: HomeAppBar(
        scaffoldKey: _scaffoldKey,
        selectedDate: '$_selectedYear Year $_selectedMonth Month',
        onMenuPressed: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        onCalendarTap: _showYearMonthPicker,
      ),
      drawer: SidebarMenu(), // 使用模块化的侧栏菜单
      body: Container(
        color: Colors.grey[100], // 整个body背景浅灰色
        padding: EdgeInsets.all(10.0), // body的padding为10
        child: Column(
          children: [
            BudgetSummary(
              totalBudget: 2000,
              consumed: 900,
              remaining: 1100,
            ),
            SizedBox(height: 10.0), // 间距
            BillList(
              bills: testData,
              height: 400.0, // 设置账单列表高度
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 40, // 设置按钮宽度为40
        height: 40, // 设置按钮高度为40
        child: FloatingActionButton(
          onPressed: _onAddButtonPressed,
          backgroundColor: Color.fromRGBO(255, 196, 18, 1),
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat, // 浮动按钮位置设置为底部中央
    );
  }
}
