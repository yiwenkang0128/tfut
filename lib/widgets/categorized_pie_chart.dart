import 'package:flutter/material.dart';
import 'dart:math';

class CategorizedPieChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const CategorizedPieChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    double totalAmount =
        data.fold(0.0, (sum, item) => sum + (item['amount'] as double));

    return SizedBox(
      height: 150, // 环状图高度
      width: 150, // 环状图宽度
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(150, 150), // 环状图大小
            painter: _RingChartPainter(data: data, totalAmount: totalAmount),
          ),
          Text(
            "\$${totalAmount.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _RingChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;
  final double totalAmount;

  _RingChartPainter({required this.data, required this.totalAmount});

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final Offset center = Offset(centerX, centerY);
    final double radius = min(size.width / 2, size.height / 2) - 10;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30; // 环的宽度

    double startAngle = -pi / 2;

    for (var item in data) {
      final double sweepAngle = (item['amount'] / totalAmount) * 2 * pi;
      paint.color = item['color'] as Color;

      // 绘制环状图部分
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
