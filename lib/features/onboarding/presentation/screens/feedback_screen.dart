import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../widgets/onboarding_character.dart';

class FeedbackScreen extends StatelessWidget {
  final bool isCorrect;

  const FeedbackScreen({super.key, required this.isCorrect});

  @override
  Widget build(BuildContext context) {
    final title = isCorrect ? 'Correct!' : 'Almost';
    final message = isCorrect
        ? 'Nice work. Your pronunciation is getting stronger.'
        : 'That was close. Let’s try again with a clearer sound.';

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: OnboardingCharacter(
                  state: isCorrect ? OnboardingCharacterState.correct : OnboardingCharacterState.wrong,
                  height: 230,
                ),
              ),
              const SizedBox(height: 12),
              Text(title, style: AppTextStyles.headline),
              const SizedBox(height: 6),
              Text(message, style: AppTextStyles.bodyMuted),
              const Spacer(),
              PrimaryButton(
                label: 'Continue',
                onPressed: () => context.go('/onboarding/celebration'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

