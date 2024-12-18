import 'package:flutter/material.dart';

class TopNavigation extends StatefulWidget implements PreferredSizeWidget {
  final String selectedTab;
  final ValueChanged<String> onTabChanged;

  TopNavigation({
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  _TopNavigationState createState() => _TopNavigationState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TopNavigationState extends State<TopNavigation> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.close, color: Colors.black),
        onPressed: () {
          Navigator.of(context).pushNamed('/home');
        },
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              widget.onTabChanged('Expense');
            },
            child: Text(
              'Expense',
              style: TextStyle(
                color:
                    widget.selectedTab == 'Expense' ? Colors.red : Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 20),
          GestureDetector(
            onTap: () {
              widget.onTabChanged('Income');
            },
            child: Text(
              'Income',
              style: TextStyle(
                color:
                    widget.selectedTab == 'Income' ? Colors.red : Colors.grey,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
