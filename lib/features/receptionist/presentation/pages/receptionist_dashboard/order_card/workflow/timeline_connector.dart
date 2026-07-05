import 'package:dental_link_dashboard/core/constants/app_colors/app_light_colors.dart';
import 'package:flutter/material.dart';

class TimelineConnector extends StatelessWidget {
  final bool isCompleted;

  const TimelineConnector({super.key, required this.isCompleted});

  /// المسافة بين دائرتين فقط
  static const double connectorWidth = 10;

  /// نفس قطر الدائرة في TimelineNode
  static const double circleSize = 42;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: connectorWidth,
      height: circleSize,
      child: CustomPaint(painter: _ConnectorPainter(isCompleted: isCompleted)),
    );
  }
}

class _ConnectorPainter extends CustomPainter {
  final bool isCompleted;

  const _ConnectorPainter({required this.isCompleted});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..color = isCompleted ? AppLightColors.success : const Color(0xffCBD5E1);

    final y = size.height / 2;

    // نرسم الخط أطول من الـ SizedBox ليصل داخل الدائرتين
    canvas.drawLine(Offset(-18, y), Offset(size.width + 18, y), paint);
  }

  @override
  bool shouldRepaint(covariant _ConnectorPainter oldDelegate) {
    return oldDelegate.isCompleted != isCompleted;
  }
}
