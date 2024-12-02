import 'package:flutter/material.dart';
import 'package:i_budget/widgets/avatar_generator.dart';

class SidebarMenu extends StatefulWidget {
  @override
  _SidebarMenuState createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
  double _monthlyBudget = 0.0;

  void _showBudgetDialog() {
    final TextEditingController budgetController =
        TextEditingController(text: _monthlyBudget.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Edit Monthly Budget'),
          content: TextField(
            controller: budgetController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter your budget amount',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _monthlyBudget =
                      double.tryParse(budgetController.text) ?? _monthlyBudget;
                });
                Navigator.pop(context); // Close dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.zero, // 去掉圆角
        child: Drawer(
          backgroundColor: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(194, 255, 184, 77), // 设置背景颜色为灰色
                        ),
                        accountName: Text(
                          'User',
                          style: TextStyle(
                            color: Colors.black, // 设置字体颜色为黑色
                          ),
                        ),
                        accountEmail: Text(
                          'user@example.com',
                          style: TextStyle(
                            color: Colors.black, // 设置字体颜色为黑色
                          ),
                        ),
                        currentAccountPicture: generateAvatar('User')),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('个人资料'),
                      onTap: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.attach_money),
                      title: Text('预算管理'),
                      onTap: _showBudgetDialog,
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('设置'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  '登出',
                  style: TextStyle(color: Color.fromRGBO(255, 148, 18, 1)),
                ),
                leading:
                    Icon(Icons.logout, color: Color.fromRGBO(255, 148, 18, 1)),
                onTap: () {
                  // 弹出提示并跳转到登录页面
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('已登出')),
                  );
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
