import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/onboarding_character.dart';

class SummaryScreen extends ConsumerWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(onboardingControllerProvider).profile;
    final name = profile.name.isEmpty ? 'friend' : profile.name;
    final goal = profile.goal.isEmpty ? 'learn Nkwen' : profile.goal.toLowerCase();

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
                  height: 210,
                ),
              ),
              const SizedBox(height: 12),
              Text('Ready, $name?', style: AppTextStyles.headline),
              const SizedBox(height: 6),
              Text('You’re here to $goal — let’s make it real.', style: AppTextStyles.bodyMuted),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your plan', style: AppTextStyles.title),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.flag_outlined),
                        const SizedBox(width: 10),
                        Expanded(child: Text('Goal: ${profile.goal.isEmpty ? 'Not set' : profile.goal}')),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.schedule),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Commitment: ${profile.commitmentLevel.isEmpty ? 'Not set' : profile.commitmentLevel}',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Start learning',
                onPressed: () => context.goNamed(RouteNames.home),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

