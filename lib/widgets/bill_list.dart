import 'package:flutter/material.dart';

class BillList extends StatelessWidget {
  final List<Map<String, dynamic>> bills;
  final double height; // 添加一个高度参数

  BillList({required this.bills, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height, // 固定高度
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0), // 圆角裁剪父容器和子组件
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // 整个父容器背景为浅灰色
          ),
          child: ListView.builder(
            padding: EdgeInsets.zero, // 去除内部边距
            itemCount: bills.length,
            itemBuilder: (context, index) {
              final bill = bills[index];
              final date = bill['date'];
              final netExpense = bill['netExpense'];
              final expenses = bill['expenses'];
              final incomes = bill['incomes'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 日期组件
                  Container(
                    // margin: const EdgeInsets.only(top: 5.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[200]!,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          date,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '净支出: $netExpense',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  // 支出列表
                  ...expenses.map<Widget>((expense) {
                    return Container(
                      // margin: const EdgeInsets.only(bottom: 5.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[200]!,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "• ",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                expense['category'],
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                          Text(
                            '-${expense['amount']}',
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        ],
                      ),
                    );
                  }),
                  // 收入列表
                  ...incomes.map<Widget>((income) {
                    return Container(
                      // margin: const EdgeInsets.only(bottom: 5.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[200]!,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "• ",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                income['category'],
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                          Text(
                            '+${income['amount']}',
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
