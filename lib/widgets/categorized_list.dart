import 'package:flutter/material.dart';

class CategorizedList extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  CategorizedList({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data.map((item) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.circle, size: 8, color: item['color']),
                SizedBox(width: 8),
                Text(item['type']),
              ],
            ),
            Text("¥${item['amount'].toStringAsFixed(2)}"),
          ],
        );
      }).toList(),
    );
  }
}
