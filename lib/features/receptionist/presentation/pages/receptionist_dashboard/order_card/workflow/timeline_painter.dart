import 'dart:math' as math;
import 'package:flutter/material.dart';



enum TimelineNodeState {
  pending,
  current,
  completed,
}

class TimelinePainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;
  final TimelineNodeState state;

  const TimelinePainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
    required this.state,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2 - 2;

    switch (state) {
      //---------------------------------------------------
      // COMPLETED
      //---------------------------------------------------
      case TimelineNodeState.completed:
        final fillPaint = Paint()
          ..color = color
          ..style = PaintingStyle.fill;

        canvas.drawCircle(center, radius, fillPaint);

        final checkPaint = Paint()
          ..color = Colors.white
          ..strokeWidth = 2.8
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;

        final path = Path()
          ..moveTo(
            center.dx - radius * .35,
            center.dy,
          )
          ..lineTo(
            center.dx - radius * .08,
            center.dy + radius * .28,
          )
          ..lineTo(
            center.dx + radius * .38,
            center.dy - radius * .25,
          );

        canvas.drawPath(path, checkPaint);

        break;

      //---------------------------------------------------
      // CURRENT
      //---------------------------------------------------
      case TimelineNodeState.current:
        final bgPaint = Paint()
          ..color = backgroundColor
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke;

        canvas.drawCircle(center, radius, bgPaint);

        final progressPaint = Paint()
          ..color = color
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;

        final sweep = progress.clamp(0.0, 1.0) * 2 * math.pi;

        canvas.drawArc(
          Rect.fromCircle(
            center: center,
            radius: radius,
          ),
          -math.pi / 2,
          sweep,
          false,
          progressPaint,
        );

        final innerPaint = Paint()
          ..color = color
          ..style = PaintingStyle.fill;

        canvas.drawCircle(
          center,
          radius * .28,
          innerPaint,
        );

        break;

      //---------------------------------------------------
      // PENDING
      //---------------------------------------------------
      case TimelineNodeState.pending:
        final borderPaint = Paint()
          ..color = backgroundColor
          ..strokeWidth = 2.5
          ..style = PaintingStyle.stroke;

        canvas.drawCircle(
          center,
          radius,
          borderPaint,
        );

        break;
    }
  }

  @override
  bool shouldRepaint(covariant TimelinePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.state != state;
  }
}