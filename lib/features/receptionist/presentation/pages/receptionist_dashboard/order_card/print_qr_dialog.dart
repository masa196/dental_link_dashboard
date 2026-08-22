/*import 'dart:typed_data';

import 'package:flutter/material.dart';

class PrintQrDialog extends StatelessWidget {
  const PrintQrDialog({
    super.key,
    required this.imageBytes,
    required this.onPrint,
  });

  final Uint8List imageBytes;
  final VoidCallback onPrint;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 420,
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'QR Code',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              Image.memory(
                imageBytes,
                width: 260,
                height: 260,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('إغلاق'),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: FilledButton(
                      onPressed: onPrint,
                      child: const Text('طباعة'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/