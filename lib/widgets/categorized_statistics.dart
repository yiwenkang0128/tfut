import 'package:flutter/material.dart';
import 'categorized_pie_chart.dart';

class CategorizedStatistics extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const CategorizedStatistics({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    double totalAmount =
        data.fold(0.0, (sum, item) => sum + (item['amount'] as double));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            "分类统计",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // 调用环状图
          CategorizedPieChart(data: data),
          const SizedBox(height: 16),
          // 分类列表
          Column(
            children: data.map((item) {
              double percentage = (item['amount'] / totalAmount) * 100;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.circle, size: 8, color: item['color']),
                      const SizedBox(width: 8),
                      Text(
                        item['type'],
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${percentage.toStringAsFixed(2)}%",
                        style: TextStyle(
                          fontSize: 12,
                          color: item['color'], // 使用对应颜色标注
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "\$${item['amount'].toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
