import 'package:flutter/material.dart';
import 'package:i_budget/widgets/pie_chart.dart';

class BudgetSummary extends StatelessWidget {
  final int totalBudget; // 总预算
  final int consumed; // 已消费
  final int remaining; // 剩余额度

  BudgetSummary({
    required this.totalBudget,
    required this.consumed,
    required this.remaining,
  });

  @override
  Widget build(BuildContext context) {
    int consumedPercentage = (consumed / totalBudget * 100).ceil();

    return Container(
      width: double.infinity,
      height: 100, // 固定高度
      padding: EdgeInsets.all(10.0), // 内边距
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
              Text(
                '本月预算',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Icon(Icons.attach_money, size: 18, color: Colors.green),
                  Text(
                    '$totalBudget',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.attach_money, size: 18, color: Colors.blue),
                        Text(
                          '$remaining',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                    Text(
                      '剩余额度',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                color: Colors.grey[300],
                margin: EdgeInsets.symmetric(vertical: 5.0), // 短线间距
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.attach_money, size: 18, color: Colors.red),
                        Text(
                          '$consumed',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                    Text(
                      '已消费',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                color: Colors.grey[300],
                margin: EdgeInsets.symmetric(vertical: 5.0), // 短线间距
              ),
              Expanded(
                child: Center(
                  child: CustomPaint(
                    size: Size(40, 40),
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
