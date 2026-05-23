import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({super.key, required this.overlayOpacity});
  final double overlayOpacity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset("assets/images/screen.png", fit: BoxFit.cover),
        ),
        Positioned.fill(child: Container()),
      ],
    );
  }
}
