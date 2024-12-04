import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String selectedDate;
  final VoidCallback onMenuPressed;
  final VoidCallback onCalendarTap;

  const HomeAppBar({super.key, 
    required this.scaffoldKey,
    required this.selectedDate,
    required this.onMenuPressed,
    required this.onCalendarTap,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white, // 顶部栏背景色
        ),
        child: AppBar(
          elevation: 0, // 去掉AppBar自带的阴影
          backgroundColor: Colors.white, // 设置透明背景
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: onMenuPressed,
          ),
          title: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(selectedDate),
                MouseRegion(
                  cursor: SystemMouseCursors.click, // 鼠标悬停时显示手形
                  child: GestureDetector(
                    onTap: onCalendarTap,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.calendar_today,
                        color: Colors.blue, // 图标颜色为蓝色
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.pie_chart),
              color: const Color.fromARGB(194, 255, 184, 77),
              onPressed: () {
                Navigator.pushNamed(context, '/overview');
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
