/*import 'package:flutter/material.dart';

class MatrixCell extends StatelessWidget {
  const MatrixCell({
    super.key,
    required this.width,
    required this.child,
    this.height = 54,
    this.alignment = Alignment.center,
    this.padding = const EdgeInsets.symmetric(horizontal: 14),
    this.backgroundColor,
    this.border,
  });

  final double width;
  final double height;
  final Widget child;
  final Alignment alignment;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: alignment,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,

        // 🔥 border خفيف جداً (بدون right ثقيل)
        border: Border(bottom: BorderSide(color: Colors.black12, width: 0.5)),
      ),
      child: child,
    );
  }
}
*/