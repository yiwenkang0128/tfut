import 'package:flutter/material.dart';

class BillList extends StatelessWidget {
  final List<Map<String, dynamic>> bills;
  final double height; // 添加一个高度参数

  const BillList({super.key, required this.bills, required this.height});

  @override
  Widget build(BuildContext context) {
    return bills.isEmpty
        ? Center(
            child: Text(
              'No bills available',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          )
        : SizedBox(
            height: height, // 固定高度
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0), // 圆角裁剪父容器和子组件
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white, // 整个父容器背景为浅灰色
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero, // 去除内部边距
                  itemCount: bills.length,
                  itemBuilder: (context, index) {
                    final bill = bills[index];
                    final date = bill['date'] ?? 'Unknown Date';
                    final netExpense = bill['netExpense'] ?? 0;
                    final expenses = bill['expenses'] ?? []; // 确保非空
                    final incomes = bill['incomes'] ?? []; // 确保非空

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2.0,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 日期和净支出
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  date,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Net: $netExpense',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: netExpense < 0
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            // 支出列表
                            if (expenses.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Expenses:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                  ...expenses.map<Widget>((expense) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            expense['category'] ?? 'Unknown',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            '-${expense['amount'] ?? 0}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            // 收入列表
                            if (incomes.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Incomes:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  ...incomes.map<Widget>((income) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            income['category'] ?? 'Unknown',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            '+${income['amount'] ?? 0}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            // 无支出或收入时的提示
                            if (expenses.isEmpty && incomes.isEmpty)
                              const Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  'No expenses or incomes for this date.',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
  }
}
