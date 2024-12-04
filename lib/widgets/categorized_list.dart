import 'package:flutter/material.dart';

class CategorizedList extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const CategorizedList({super.key, required this.data});

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
                const SizedBox(width: 8),
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
