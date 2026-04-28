import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/onboarding_character.dart';
import '../widgets/onboarding_option_card.dart';

class GoalSelectionScreen extends ConsumerStatefulWidget {
  const GoalSelectionScreen({super.key});

  @override
  ConsumerState<GoalSelectionScreen> createState() => _GoalSelectionScreenState();
}

class _GoalSelectionScreenState extends ConsumerState<GoalSelectionScreen> {
  String? _selected;

  @override
  void initState() {
    super.initState();
    final current = ref.read(onboardingControllerProvider).profile.goal;
    _selected = current.isEmpty ? null : current;
  }

  @override
  Widget build(BuildContext context) {
    final options = const [
      ('Speak with family', 'Everyday greetings and conversations'),
      ('Travel & culture', 'Useful phrases for visiting home'),
      ('School & study', 'Structured learning, step by step'),
      ('Just curious', 'A fun start with short lessons'),
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
                  state: OnboardingCharacterState.happy,
                  height: 190,
                ),
              ),
              const SizedBox(height: 12),
              Text('What’s your goal?', style: AppTextStyles.headline),
              const SizedBox(height: 6),
              Text('Pick one to customize your path.', style: AppTextStyles.bodyMuted),
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
                      leading: const Icon(Icons.flag_outlined),
                    );
                  },
                ),
              ),
              PrimaryButton(
                label: 'Continue',
                onPressed: _selected == null ? null : () => _continue(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _continue(BuildContext context) async {
    final goal = _selected;
    if (goal == null) return;
    await ref.read(onboardingControllerProvider.notifier).setGoal(goal);
    if (!context.mounted) return;
    context.go('/onboarding/problem');
  }
}

