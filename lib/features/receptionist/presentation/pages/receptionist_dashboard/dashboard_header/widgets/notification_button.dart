import 'package:flutter/material.dart';

class NotificationButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const NotificationButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.notifications_none_outlined,
            color: scheme.onSurfaceVariant,
          ),
        ),
        Positioned(
          top: 12,
          left: 12,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.redAccent,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}