
import 'package:flutter/material.dart';


class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key, this.onPressed, this.count = 0});

  final VoidCallback? onPressed;
  final int count;

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

/*
        if (count > 0)
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                count > 99 ? '99+' : '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          */
      ],
    );
  }
}
