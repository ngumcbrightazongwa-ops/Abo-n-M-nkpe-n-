import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../widgets/adaptive_asset_image.dart';
import '../widgets/onboarding_audio_card.dart';
import '../widgets/onboarding_background.dart';
import '../widgets/onboarding_primary_button.dart';
import '../widgets/onboarding_progress_header.dart';
import '../widgets/onboarding_title_with_marks.dart';

class AhaMomentScreen extends StatelessWidget {
  const AhaMomentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: OnboardingBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.pagePadding),
            child: Column(
              children: [
                const SizedBox(height: 4),
                const OnboardingProgressHeader(currentStep: 4, totalSteps: 5),
                const SizedBox(height: 14),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 6),
                      const AdaptiveAssetImage(
                        basePath: 'assets/characters/child_thinking',
                        height: 320,
                      ),
                      const SizedBox(height: 18),
                      const OnboardingTitleWithMarks(title: 'Did you understand that?'),
                      const SizedBox(height: 10),
                      Text(
                        'Don’t worry. Let’s fix that together.',
                        style: AppTextStyles.bodyMuted.copyWith(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 18),
                      OnboardingAudioCard(
                        onPressed: () => context.showSnack('Sample audio will be added soon.'),
                      ),
                      const SizedBox(height: 22),
                      const Icon(Icons.favorite_border, color: AppColors.primaryGreen),
                      const SizedBox(height: 10),
                      Text(
                        'Even if you missed it,\nwe’ll teach you step by step.',
                        style: AppTextStyles.bodyMuted.copyWith(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                OnboardingPrimaryButton(
                  label: 'Continue',
                  onPressed: () => context.go('/onboarding/lesson'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
