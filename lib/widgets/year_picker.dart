import 'package:flutter/material.dart';

class CustomYearPicker extends StatelessWidget {
  final int selectedYear;
  final Function(int) onYearChanged;

  const CustomYearPicker({super.key, 
    required this.selectedYear,
    required this.onYearChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: selectedYear,
      items: List.generate(10, (index) {
        int year = DateTime.now().year - index;
        return DropdownMenuItem(
          value: year,
          child: Text("$year 年"),
        );
      }),
      onChanged: (value) {
        if (value != null) onYearChanged(value);
      },
    );
  }
}
