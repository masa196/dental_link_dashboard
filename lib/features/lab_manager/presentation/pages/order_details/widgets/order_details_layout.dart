import 'package:flutter/material.dart';

class OrderDetailsLayout extends StatelessWidget {
  const OrderDetailsLayout({
    super.key,
    required this.left,
    required this.right,
  });

  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 900;

    if (isMobile) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            right,
            const SizedBox(height: 24),
            left,
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 65,
            child: left,
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 35,
            child: right,
          ),
        ],
      ),
    );
  }
}