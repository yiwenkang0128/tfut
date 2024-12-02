import 'package:flutter/material.dart';
import '../widgets/year_month_picker.dart';

class OverviewBar extends StatelessWidget {
  final String selectedView;
  final Function(String) onSelectedViewChanged;
  final int selectedYear;
  final int selectedMonth;
  final Function(int, int?) onYearMonthChanged;

  OverviewBar({
    required this.selectedView,
    required this.onSelectedViewChanged,
    required this.selectedYear,
    required this.selectedMonth,
    required this.onYearMonthChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 第一行
        Container(
          height: 50,
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushNamed(context, '/home'); // 跳转到 /home
                },
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ToggleButtons(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text("月"),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text("年"),
                        ),
                      ],
                      isSelected: [
                        selectedView == "month",
                        selectedView == "year"
                      ],
                      onPressed: (index) {
                        onSelectedViewChanged(index == 0 ? "month" : "year");
                      },
                      fillColor: Colors.orange[100], // 选中时背景颜色
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // 第二行
        Container(
          height: 40,
          color: Colors.white,
          child: selectedView == "month"
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$selectedYear年 $selectedMonth月",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8.0),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                backgroundColor: Colors.white,
                                child: SizedBox(
                                  height: 400,
                                  child: YearMonthPicker(
                                    selectedYear: selectedYear,
                                    selectedMonth: selectedMonth,
                                    onYearMonthChanged: onYearMonthChanged,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child:
                            Icon(Icons.arrow_drop_down, color: Colors.orange),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<int>(
                      value: selectedYear,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.orange),
                      items: List.generate(10, (index) {
                        int year = DateTime.now().year - index;
                        return DropdownMenuItem<int>(
                          value: year,
                          child: Text(
                            "$year年",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none),
                          ),
                        );
                      }),
                      onChanged: (value) {
                        if (value != null) {
                          onYearMonthChanged(value, null);
                        }
                      },
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
