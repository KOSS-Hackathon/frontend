import 'dart:math';
import 'package:flutter/material.dart';

class ArcText extends StatelessWidget {
  final String text;
  final double radius;
  final TextStyle style;

  const ArcText({
    super.key,
    required this.text,
    required this.radius,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ArcTextPainter(
        text: text,
        radius: radius,
        style: style,
      ),
    );
  }
}

class _ArcTextPainter extends CustomPainter {
  final String text;
  final double radius;
  final TextStyle style;

  _ArcTextPainter({
    required this.text,
    required this.radius,
    required this.style,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final characters = text.split('');

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    final totalAngle = pi * 0.65;
    final anglePerChar = totalAngle / (characters.length - 1);
    final startAngle = -totalAngle / 2;

    for (int i = 0; i < characters.length; i++) {
      final char = characters[i];
      final angle = startAngle + anglePerChar * i;

      textPainter.text = TextSpan(
        text: char,
        style: style,
      );
      textPainter.layout();

      final x = center.dx + radius * sin(angle) - textPainter.width / 2;
      final y = center.dy - radius * cos(angle) - textPainter.height / 2;

      canvas.save();
      canvas.translate(x + textPainter.width / 2, y + textPainter.height / 2);
      canvas.rotate(angle);
      canvas.translate(-textPainter.width / 2, -textPainter.height / 2);
      textPainter.paint(canvas, Offset.zero);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}