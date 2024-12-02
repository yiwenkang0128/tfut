import 'package:flutter/material.dart';
import 'package:i_budget/pages/test_data.dart';
import '../widgets/overview_bar.dart';
import '../widgets/overview_data.dart';
import '../widgets/categorized_statistics.dart';

class OverviewPage extends StatefulWidget {
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  String selectedView = "month"; // month or year
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: OverviewBar(
          selectedView: selectedView,
          onSelectedViewChanged: (view) {
            setState(() {
              selectedView = view;
            });
          },
          selectedYear: selectedYear,
          selectedMonth: selectedMonth,
          onYearMonthChanged: (year, month) {
            setState(() {
              selectedYear = year;
              selectedMonth = month ?? selectedMonth; // 如果 month 为 null，保留原值
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            OverviewData(
              expenditure: 2200.00,
              income: 5000.00,
              balance: 2800.00,
            ),
            SizedBox(height: 10),
            CategorizedStatistics(
              data: TestData.categorizedExpenditure, // 使用类名访问静态成员
            ),
          ],
        ),
      ),
    );
  }
}
