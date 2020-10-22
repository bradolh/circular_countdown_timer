import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    this.percent,
    this.fillColor,
    this.color,
    this.strokeWidth,
    this.backgroundColor,
  });

  final double percent;
  final Color fillColor, color, backgroundColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = fillColor
      ..strokeWidth = strokeWidth ?? 5.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - percent) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);

    if (backgroundColor != null) {
      final backgroundPaint = Paint();
      backgroundPaint.color = backgroundColor;
      canvas.drawCircle(
          size.center(Offset.zero), size.width / 2.2, backgroundPaint);
    }
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return percent != old.percent ||
        color != old.color ||
        fillColor != old.fillColor;
  }
}
