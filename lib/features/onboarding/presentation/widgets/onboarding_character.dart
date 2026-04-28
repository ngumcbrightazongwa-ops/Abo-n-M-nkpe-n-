import 'package:flutter/material.dart';

enum OnboardingCharacterState { happy, correct, wrong, thinking, celebration }

extension OnboardingCharacterStateX on OnboardingCharacterState {
  String get assetPath {
    switch (this) {
      case OnboardingCharacterState.happy:
        return 'assets/characters/child_happy.png';
      case OnboardingCharacterState.correct:
        return 'assets/characters/child_correct.png';
      case OnboardingCharacterState.wrong:
        return 'assets/characters/child_wrong.png';
      case OnboardingCharacterState.thinking:
        return 'assets/characters/child_thinking.png';
      case OnboardingCharacterState.celebration:
        return 'assets/characters/child_celebration.png';
    }
  }
}

class OnboardingCharacter extends StatelessWidget {
  final OnboardingCharacterState state;
  final double height;

  const OnboardingCharacter({
    super.key,
    required this.state,
    this.height = 220,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      child: Image.asset(
        state.assetPath,
        key: ValueKey(state),
        height: height,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return SizedBox(
            height: height,
            child: const Center(child: Icon(Icons.person, size: 80)),
          );
        },
      ),
    );
  }
}
