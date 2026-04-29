import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/onboarding_character.dart';
import '../widgets/onboarding_option_card.dart';

class CommitmentScreen extends ConsumerStatefulWidget {
  const CommitmentScreen({super.key});

  @override
  ConsumerState<CommitmentScreen> createState() => _CommitmentScreenState();
}

class _CommitmentScreenState extends ConsumerState<CommitmentScreen> {
  String? _selected;

  @override
  void initState() {
    super.initState();
    final current = ref.read(onboardingControllerProvider).profile.commitmentLevel;
    _selected = current.isEmpty ? null : current;
  }

  @override
  Widget build(BuildContext context) {
    final options = const [
      ('Light', '3 minutes a day'),
      ('Steady', '10 minutes a day'),
      ('Focused', '20 minutes a day'),
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
              Text('Pick your commitment', style: AppTextStyles.headline),
              const SizedBox(height: 6),
              Text('You can change this later.', style: AppTextStyles.bodyMuted),
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
                      leading: const Icon(Icons.schedule),
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
    final level = _selected;
    if (level == null) return;
    await ref.read(onboardingControllerProvider.notifier).setCommitmentLevel(level);
    if (!context.mounted) return;
    context.push('/onboarding/summary');
  }
}

