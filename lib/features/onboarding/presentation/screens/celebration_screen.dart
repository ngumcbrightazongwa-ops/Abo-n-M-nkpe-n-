import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../widgets/confetti_view.dart';
import '../widgets/onboarding_character.dart';

class CelebrationScreen extends StatelessWidget {
  const CelebrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.pagePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: OnboardingCharacter(
                      state: OnboardingCharacterState.celebration,
                      height: 240,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('You did it!', style: AppTextStyles.headline),
                  const SizedBox(height: 6),
                  Text('Small steps build real fluency.', style: AppTextStyles.bodyMuted),
                  const Spacer(),
                  PrimaryButton(
                    label: 'Continue',
                    onPressed: () => context.go('/onboarding/streak'),
                  ),
                ],
              ),
            ),
          ),
          const ConfettiView(enabled: true),
        ],
      ),
    );
  }
}

