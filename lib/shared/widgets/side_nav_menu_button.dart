import 'package:flutter/material.dart';

class SideNavMenuButton extends StatelessWidget {
  const SideNavMenuButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu),
      tooltip: 'Menu',
      onPressed: onTap,
    );
  }
}