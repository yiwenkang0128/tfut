import 'package:flutter/material.dart';

class OverviewData extends StatelessWidget {
  final double expenditure;
  final double income;
  final double balance;

  const OverviewData({super.key, 
    required this.expenditure,
    required this.income,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            "收支总览",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text("Expense"),
                    Text("$expenditure", style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              Container(width: 1, color: Colors.grey[300]),
              Expanded(
                child: Column(
                  children: [
                    const Text("Income"),
                    Text("$income", style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              Container(width: 1, color: Colors.grey[300]),
              Expanded(
                child: Column(
                  children: [
                    const Text("结余"),
                    Text("$balance", style: const TextStyle(fontSize: 16)),
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
