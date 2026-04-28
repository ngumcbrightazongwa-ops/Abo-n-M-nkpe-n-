import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../widgets/onboarding_character.dart';

class StreakScreen extends StatelessWidget {
  const StreakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: OnboardingCharacter(
                  state: OnboardingCharacterState.happy,
                  height: 200,
                ),
              ),
              const SizedBox(height: 12),
              Text('Day 1 streak', style: AppTextStyles.headline),
              const SizedBox(height: 6),
              Text('Come back tomorrow to keep it going.', style: AppTextStyles.bodyMuted),
              const SizedBox(height: 16),
              AppCard(
                child: Row(
                  children: [
                    const Icon(Icons.local_fire_department, color: Colors.orange),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Streak: 1 day', style: AppTextStyles.title),
                          const SizedBox(height: 4),
                          Text('You’re on track.', style: AppTextStyles.bodyMuted),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Continue',
                onPressed: () => context.go('/onboarding/commitment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

