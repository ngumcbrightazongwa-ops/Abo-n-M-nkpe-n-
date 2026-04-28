import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../widgets/onboarding_character.dart';
import '../widgets/onboarding_option_card.dart';

class ProblemAwarenessScreen extends StatefulWidget {
  const ProblemAwarenessScreen({super.key});

  @override
  State<ProblemAwarenessScreen> createState() => _ProblemAwarenessScreenState();
}

class _ProblemAwarenessScreenState extends State<ProblemAwarenessScreen> {
  String? _selected;

  @override
  Widget build(BuildContext context) {
    final options = const [
      ('I freeze when speaking', 'I know words, but they don’t come out'),
      ('I’m worried about mistakes', 'I don’t want to sound wrong'),
      ('I just need practice', 'I understand, but speaking feels hard'),
      ('I’m confident already', 'I want to go faster'),
    ];

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
                  height: 190,
                ),
              ),
              const SizedBox(height: 12),
              Text('How do you feel about speaking?', style: AppTextStyles.headline),
              const SizedBox(height: 6),
              Text('Be honest — we’ll adapt to you.', style: AppTextStyles.bodyMuted),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: options.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final (title, subtitle) = options[index];
                    return OnboardingOptionCard(
                      title: title,
                      subtitle: subtitle,
                      selected: _selected == title,
                      onTap: () => setState(() => _selected = title),
                      leading: const Icon(Icons.chat_bubble_outline),
                    );
                  },
                ),
              ),
              PrimaryButton(
                label: 'Continue',
                onPressed: _selected == null ? null : () => context.go('/onboarding/aha'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

