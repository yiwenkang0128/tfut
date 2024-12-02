import 'package:flutter/material.dart';

class OverviewData extends StatelessWidget {
  final double expenditure;
  final double income;
  final double balance;

  OverviewData({
    required this.expenditure,
    required this.income,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            "收支总览",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text("支出"),
                    Text("$expenditure", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              Container(width: 1, color: Colors.grey[300]),
              Expanded(
                child: Column(
                  children: [
                    Text("收入"),
                    Text("$income", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              Container(width: 1, color: Colors.grey[300]),
              Expanded(
                child: Column(
                  children: [
                    Text("结余"),
                    Text("$balance", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
