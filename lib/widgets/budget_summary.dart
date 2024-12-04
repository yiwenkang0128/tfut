import 'package:flutter/material.dart';
import 'package:i_budget/widgets/pie_chart.dart';

class BudgetSummary extends StatelessWidget {
  final int totalBudget; // 总预算
  final int consumed; // 已消费
  final int remaining; // 剩余额度

  const BudgetSummary({
    super.key,
    required this.totalBudget,
    required this.consumed,
    required this.remaining,
  });

  @override
  Widget build(BuildContext context) {
    int consumedPercentage =
        totalBudget == 0 ? 0 : (consumed / totalBudget * 100).ceil();

    return Container(
      width: double.infinity,
      height: 100, // 固定高度
      padding: const EdgeInsets.all(10.0), // 内边距
      decoration: BoxDecoration(
        color: Colors.white, // 背景白色
        borderRadius: BorderRadius.circular(16.0), // 圆角
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 第一行
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '本月预算',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Icon(Icons.attach_money, size: 18, color: Colors.green),
                  Text(
                    '$totalBudget',
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.attach_money,
                            size: 18, color: Colors.blue),
                        Text(
                          '$remaining',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                    const Text(
                      '剩余额度',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                color: Colors.grey[300],
                margin: const EdgeInsets.symmetric(vertical: 5.0), // 短线间距
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.attach_money,
                            size: 18, color: Colors.red),
                        Text(
                          '$consumed',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                    const Text(
                      '已消费',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                color: Colors.grey[300],
                margin: const EdgeInsets.symmetric(vertical: 5.0), // 短线间距
              ),
              Expanded(
                child: Center(
                  child: CustomPaint(
                    size: const Size(40, 40),
                    painter: PieChartPainter(
                      consumedPercentage: consumedPercentage,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
