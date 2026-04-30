import 'package:flutter/material.dart';

class OnboardingBackground extends StatelessWidget {
  final Widget child;

  const OnboardingBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/onboarding _background_pure_white.jpg',
            fit: BoxFit.cover,
          ),
        ),
        child,
      ],
    );
  }
}
