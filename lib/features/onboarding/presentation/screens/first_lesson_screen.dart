import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../widgets/adaptive_asset_image.dart';
import '../widgets/onboarding_background.dart';
import '../widgets/onboarding_character.dart';
import '../widgets/onboarding_primary_button.dart';

class FirstLessonScreen extends StatefulWidget {
  const FirstLessonScreen({super.key});

  @override
  State<FirstLessonScreen> createState() => _FirstLessonScreenState();
}

class _FirstLessonScreenState extends State<FirstLessonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          const OnboardingBackground(child: SizedBox.expand()),
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.surface,
                    AppColors.surface,
                    Color(0x00FFFFFF),
                  ],
                  stops: [0, 0.6, 1],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.pagePadding),
              child: Column(
                children: [
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Material(
                        color: AppColors.surface,
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {
                            final router = GoRouter.of(context);
                            if (router.canPop()) {
                              router.pop();
                              return;
                            }
                            context.go('/onboarding/aha');
                          },
                          child: const SizedBox(
                            width: 44,
                            height: 44,
                            child: Icon(Icons.chevron_left),
                          ),
                        ),
                      ),
                      const Spacer(),
                      const _StepIndicator(count: 5, index: 4),
                      const Spacer(),
                      _LessonBadge(
                        label: 'Lesson 1',
                        onTap:
                            () => context.showSnack(
                              'Lesson details coming soon.',
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const _FirstWordTitle(),
                  const SizedBox(height: 8),
                  Text(
                    'Listen and say it out loud.',
                    style: AppTextStyles.bodyMuted.copyWith(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final heroHeight = (constraints.maxHeight * 0.34).clamp(
                          160.0,
                          280.0,
                        );

                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Transform.translate(
                                offset: const Offset(0, -6),
                                child: SizedBox(
                                  height: heroHeight,
                                  child: const AdaptiveAssetImage(
                                    basePath:
                                        'assets/characters/first_lesson_hero',
                                    fit: BoxFit.contain,
                                    alignment: Alignment.bottomCenter,
                                    fadeBottom: true,
                                    placeholder: OnboardingCharacter(
                                      state: OnboardingCharacterState.happy,
                                      height: 260,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const _WordCard(
                                label: "Today's word",
                                word: 'Mba',
                                meaning: 'hello',
                                hint: 'Listen and say it',
                              ),
                              const SizedBox(height: 18),
                              Row(
                                children: [
                                  Expanded(
                                    child: _RoundAction(
                                      icon: Icons.volume_up,
                                      label: 'Play Audio',
                                      onTap:
                                          () => context.showSnack(
                                            'Pronunciation audio will be added soon.',
                                          ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _RoundAction(
                                      icon: Icons.mic,
                                      label: 'Tap to Speak',
                                      onTap:
                                          () => context.push(
                                            '/onboarding/feedback/correct',
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              const _TipCard(
                                title: 'Tip: Speak clearly and confidently.',
                                subtitle: "You’re doing great!",
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  OnboardingPrimaryButton(
                    label: 'Continue',
                    onPressed:
                        () => context.push('/onboarding/feedback/correct'),
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LessonBadge extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const _LessonBadge({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppColors.primaryGreen.withAlpha(90)),
          ),
          child: Text(
            label,
            style: AppTextStyles.bodyMuted.copyWith(
              color: AppColors.primaryGreen,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final int count;
  final int index;

  const _StepIndicator({required this.count, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++) ...[
          if (i == index)
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: AppColors.primaryGreen,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            )
          else
            SizedBox(
              height: 24,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 26,
                  height: 6,
                  decoration: BoxDecoration(
                    color:
                        i < index ? AppColors.primaryGreen : AppColors.border,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
          if (i != count - 1) const SizedBox(width: 8),
        ],
      ],
    );
  }
}

class _FirstWordTitle extends StatelessWidget {
  const _FirstWordTitle();

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(text: '🎉  '),
          TextSpan(
            text: 'Your first word!',
            style: AppTextStyles.headline.copyWith(
              fontSize: 32,
              color: AppColors.primaryGreen,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _WordCard extends StatelessWidget {
  final String label;
  final String word;
  final String meaning;
  final String hint;

  const _WordCard({
    required this.label,
    required this.word,
    required this.meaning,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.menu_book_outlined,
                color: AppColors.primaryGreen,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyles.bodyMuted.copyWith(
                  color: AppColors.primaryGreen,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            word,
            style: AppTextStyles.headline.copyWith(
              fontSize: 56,
              height: 1.0,
              color: const Color(0xFF0B2F14),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 44, height: 1, color: AppColors.border),
              const SizedBox(width: 10),
              Text(
                meaning,
                style: AppTextStyles.title.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 10),
              Container(width: 44, height: 1, color: AppColors.border),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryGreen.withAlpha(18),
                ),
                child: const Icon(
                  Icons.sentiment_satisfied_alt,
                  color: AppColors.primaryGreen,
                  size: 14,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                hint,
                style: AppTextStyles.bodyMuted.copyWith(
                  color: AppColors.primaryGreen,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoundAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _RoundAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryGreen.withAlpha(18),
              ),
              child: Icon(icon, color: AppColors.primaryGreen, size: 32),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: AppTextStyles.bodyMuted.copyWith(
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _TipCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7E8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFDE6B1)),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: Color(0xFFFFE0A3),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.lightbulb_outline,
              color: Color(0xFFB45309),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTextStyles.bodyMuted),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
