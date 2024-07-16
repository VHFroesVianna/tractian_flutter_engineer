import 'package:flutter/material.dart';
import 'package:tractian_test/theme/app_colors.dart';

class LinesPainter extends CustomPainter {
  final double offset;

  LinesPainter(this.offset);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 1.0;

    const double startX = 0;
    const double startY = 10;
    final double endY = size.height;

    canvas.drawLine(const Offset(startX, startY), Offset(startX, endY), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
