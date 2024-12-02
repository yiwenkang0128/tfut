import 'package:flutter/material.dart';

class YearMonthPicker extends StatefulWidget {
  final int selectedYear;
  final int selectedMonth;
  final Function(int, int) onYearMonthChanged;

  YearMonthPicker({
    required this.selectedYear,
    required this.selectedMonth,
    required this.onYearMonthChanged,
  });

  @override
  _YearMonthPickerState createState() => _YearMonthPickerState();
}

class _YearMonthPickerState extends State<YearMonthPicker> {
  late int _currentYear;
  late int _currentMonth;

  @override
  void initState() {
    super.initState();
    _currentYear = widget.selectedYear;
    _currentMonth = widget.selectedMonth;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          // 年份选择部分
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_left),
                onPressed: () {
                  setState(() {
                    _currentYear--;
                  });
                },
              ),
              Text(
                '$_currentYear年',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.arrow_right),
                onPressed: () {
                  setState(() {
                    _currentYear++;
                  });
                },
              ),
            ],
          ),
          Divider(),
          // 月份选择部分
          Wrap(
            alignment: WrapAlignment.center, // 居中显示
            spacing: 20.0,
            runSpacing: 20.0,
            children: List.generate(12, (index) {
              int month = index + 1;
              return SizedBox(
                width: (MediaQuery.of(context).size.width - 80) / 4,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click, // 鼠标悬停显示手形
                  child: GestureDetector(
                    onTap: () {
                      widget.onYearMonthChanged(_currentYear, month);
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      width: 60,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _currentMonth == month
                            ? Colors.blue
                            : Colors.grey[200], // 高亮选中月份
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        '$month月',
                        style: TextStyle(
                          color: _currentMonth == month
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
