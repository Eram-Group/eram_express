import 'package:flutter/material.dart';

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5; // طول كل شرطه
    double dashSpace = 3; // المسافة بين الشرطات
    double startY = 0; // بداية الرسم على المحور Y

    final paint = Paint()
      ..color = Colors.grey // لون الشرطات
      ..strokeWidth = 2; // سمك الشرطات

    while (startY < size.height) {
      // رسم الشرطة بشكل رأسي
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashHeight),
        paint,
      );
      // تحريك المؤشر للأمام بمقدار الشرطة والمسافة بينها
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
