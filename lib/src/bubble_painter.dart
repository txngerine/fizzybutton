import 'package:flutter/material.dart';
import 'bubble.dart';

class BubblePainter extends CustomPainter {
  final List<Bubble> bubbles;
  final Color color;

  BubblePainter(this.bubbles, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (var bubble in bubbles) {
      paint.color = color.withOpacity(bubble.opacity);
      canvas.drawCircle(
        Offset(bubble.x * size.width, bubble.y * size.height),
        bubble.radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}