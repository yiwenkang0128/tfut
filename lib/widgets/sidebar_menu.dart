import 'package:flutter/material.dart';
import 'package:i_budget/widgets/avatar_generator.dart';

class SidebarMenu extends StatefulWidget {
  const SidebarMenu({super.key});

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
          title: const Text('Edit Monthly Budget'),
          content: TextField(
            controller: budgetController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter your budget amount',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _monthlyBudget =
                      double.tryParse(budgetController.text) ?? _monthlyBudget;
                });
                Navigator.pop(context); // Close dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(194, 255, 184, 77), // 设置背景颜色为灰色
                        ),
                        accountName: const Text(
                          'User',
                          style: TextStyle(
                            color: Colors.black, // 设置字体颜色为黑色
                          ),
                        ),
                        accountEmail: const Text(
                          'user@example.com',
                          style: TextStyle(
                            color: Colors.black, // 设置字体颜色为黑色
                          ),
                        ),
                        currentAccountPicture: generateAvatar('User')),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('个人资料'),
                      onTap: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.attach_money),
                      title: const Text('预算管理'),
                      onTap: _showBudgetDialog,
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('设置'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Text(
                  '登出',
                  style: TextStyle(color: Color.fromRGBO(255, 148, 18, 1)),
                ),
                leading:
                    const Icon(Icons.logout, color: Color.fromRGBO(255, 148, 18, 1)),
                onTap: () {
                  // 弹出提示并跳转到登录页面
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('已登出')),
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
