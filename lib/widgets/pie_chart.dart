import 'package:flutter/material.dart';

class PieChartPainter extends CustomPainter {
  final int consumedPercentage;

  PieChartPainter({required this.consumedPercentage});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;

    final consumedAngle = 2 * 3.14159 * (consumedPercentage / 100);
    final remainingAngle = 2 * 3.14159 - consumedAngle;

    // 绘制已消费部分
    paint.color = const Color.fromARGB(176, 244, 67, 54);
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      -3.14159 / 2,
      consumedAngle,
      false,
      paint,
    );

    // 绘制剩余额度部分
    paint.color = const Color.fromARGB(169, 33, 149, 243);
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      -3.14159 / 2 + consumedAngle,
      remainingAngle,
      false,
      paint,
    );

    // 绘制百分比文本
    final textPainter = TextPainter(
      text: TextSpan(
        text: '$consumedPercentage%',
        style: TextStyle(fontSize: 12, color: Colors.black),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        size.width / 2 - textPainter.width / 2,
        size.height / 2 - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
