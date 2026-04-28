import 'package:flutter/material.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/theme/app_text_styles.dart';
import 'onboarding_character.dart';

class OnboardingScaffold extends StatelessWidget {
  final String title;
  final String? message;
  final OnboardingCharacterState? characterState;
  final Widget child;
  final Widget footer;
  final bool showBack;

  const OnboardingScaffold({
    super.key,
    required this.title,
    this.message,
    this.characterState,
    required this.child,
    required this.footer,
    this.showBack = true,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (characterState != null) ...[
          Center(child: OnboardingCharacter(state: characterState!)),
          const SizedBox(height: 12),
        ],
        Text(title, style: AppTextStyles.headline),
        if (message != null) ...[
          const SizedBox(height: 6),
          Text(message!, style: AppTextStyles.bodyMuted),
        ],
        const SizedBox(height: 16),
        Expanded(child: child),
        const SizedBox(height: 12),
        footer,
      ],
    );

    return Scaffold(
      appBar: showBack ? AppBar() : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.pagePadding),
          child: content,
        ),
      ),
    );
  }
}
