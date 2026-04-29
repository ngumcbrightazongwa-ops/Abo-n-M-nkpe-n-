import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/audio_button.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../widgets/onboarding_character.dart';

class AhaMomentScreen extends StatelessWidget {
  const AhaMomentScreen({super.key});

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
                  state: OnboardingCharacterState.thinking,
                  height: 210,
                ),
              ),
              const SizedBox(height: 12),
              Text('Let’s fix that together', style: AppTextStyles.headline),
              const SizedBox(height: 6),
              Text(
                'Listen, repeat, and get instant feedback — like a real conversation.',
                style: AppTextStyles.bodyMuted,
              ),
              const SizedBox(height: 16),
              AudioButton(
                label: 'Play sample',
                onPressed: () => context.showSnack('Sample audio will be added soon.'),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Continue',
                onPressed: () => context.push('/onboarding/lesson'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

