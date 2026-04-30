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
  final bool fadeBottom;
  final double fadeStart;

  const OnboardingCharacter({
    super.key,
    required this.state,
    this.height = 220,
    this.fadeBottom = true,
    this.fadeStart = 0.78,
  });

  @override
  Widget build(BuildContext context) {
    final start = fadeStart.clamp(0.0, 1.0).toDouble();
    final middle = start == 1.0 ? 0.999 : start;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      child:
          fadeBottom
              ? ShaderMask(
                blendMode: BlendMode.dstIn,
                shaderCallback: (bounds) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: const [
                      Color(0xFFFFFFFF),
                      Color(0xFFFFFFFF),
                      Color(0x00FFFFFF),
                    ],
                    stops: [0, middle, 1],
                  ).createShader(bounds);
                },
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
              )
              : Image.asset(
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
