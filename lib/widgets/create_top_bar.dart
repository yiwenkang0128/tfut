import 'package:flutter/material.dart';

class TopNavigation extends StatefulWidget implements PreferredSizeWidget {
  final String selectedTab;
  final ValueChanged<String> onTabChanged;

  const TopNavigation({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  TopNavigationState createState() => TopNavigationState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class TopNavigationState extends State<TopNavigation> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.close, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
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
          const SizedBox(width: 20),
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
