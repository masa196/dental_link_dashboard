import 'package:flutter/material.dart';

class DashboardActionButton extends StatelessWidget {
  const DashboardActionButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
  });

  final String title;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 34,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : Text(title),
      ),
    );
  }
}