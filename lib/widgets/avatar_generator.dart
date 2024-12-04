import 'package:flutter/material.dart';

/// A function that generates a CircleAvatar with a border based on the given account name.
Widget generateAvatar(String accountName) {
  String initial = accountName.isNotEmpty ? accountName[0].toUpperCase() : '?';

  return Container(
    width: 60, // 调整头像大小
    height: 60,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
    ),
    child: CircleAvatar(
      backgroundColor: Colors.orange[50],
      child: Text(
        initial,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 255, 128, 0), // 文本颜色
        ),
      ),
    ),
  );
}
