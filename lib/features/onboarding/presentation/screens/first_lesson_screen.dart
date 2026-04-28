import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/audio_button.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../widgets/onboarding_character.dart';

class FirstLessonScreen extends StatefulWidget {
  const FirstLessonScreen({super.key});

  @override
  State<FirstLessonScreen> createState() => _FirstLessonScreenState();
}

class _FirstLessonScreenState extends State<FirstLessonScreen> {
  bool _isCorrect = true;

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
                  height: 190,
                ),
              ),
              const SizedBox(height: 12),
              Text('Your first word', style: AppTextStyles.headline),
              const SizedBox(height: 6),
              Text('Say it out loud — we’ll guide you.', style: AppTextStyles.bodyMuted),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSizes.cardPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.cardRadius),
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ǹjwelǎ', style: AppTextStyles.headline.copyWith(fontSize: 30)),
                    const SizedBox(height: 6),
                    Text('Good morning', style: AppTextStyles.bodyMuted),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: AudioButton(
                      label: 'Listen',
                      onPressed: () => context.showSnack('Pronunciation audio will be added soon.'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  FilledButton.tonalIcon(
                    onPressed: () => context.showSnack('Microphone practice is UI-only for onboarding.'),
                    icon: const Icon(Icons.mic_none),
                    label: const Text('Speak'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SwitchListTile.adaptive(
                value: _isCorrect,
                onChanged: (value) => setState(() => _isCorrect = value),
                title: const Text('Simulate correct'),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Check',
                onPressed: () => context.go(
                  '/onboarding/feedback/${_isCorrect ? 'correct' : 'wrong'}',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

