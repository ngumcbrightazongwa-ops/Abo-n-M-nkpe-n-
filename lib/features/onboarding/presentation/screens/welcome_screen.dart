import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../widgets/adaptive_asset_image.dart';
import '../widgets/onboarding_background.dart';
import '../widgets/onboarding_page_indicator.dart';
import '../widgets/onboarding_primary_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
                const SizedBox(height: 8),
                Column(
                  children: [
                    const AdaptiveAssetImage(
                      basePath: 'assets/images/nkwen_logo',
                      height: 230,
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  final maxByHeight =
                                      constraints.maxHeight.isFinite
                                          ? constraints.maxHeight * 0.55
                                          : 240.0;
                                  final diameter = math
                                      .min(constraints.maxWidth, maxByHeight)
                                      .clamp(140.0, 360.0);

                                  return SizedBox.square(
                                    dimension: diameter,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.primaryGreen.withAlpha(
                                          26,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: ClipOval(
                                        child: const AdaptiveAssetImage(
                                          basePath:
                                              'assets/characters/welcome_family',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 22),
                              _WelcomeTitle(),
                              const SizedBox(height: 10),
                              Text(
                                'Welcome to Nkwen learning.',
                                style: AppTextStyles.title.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Let’s learn. Let’s speak. Let’s connect.',
                                style: AppTextStyles.bodyMuted,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                const OnboardingPageIndicator(count: 3, index: 0),
                const SizedBox(height: 18),
                OnboardingPrimaryButton(
                  label: 'Get Started',
                  onPressed: () => context.go('/onboarding/name'),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WelcomeTitle extends StatelessWidget {
  const _WelcomeTitle();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Text(
          'Njwelà!',
          style: AppTextStyles.headline.copyWith(
            fontSize: 42,
            color: AppColors.primaryGreen,
          ),
        ),
        Positioned(
          left: -26,
          child: _Marks(
            colors: const [
              Color(0xFFF59E0B),
              Color(0xFFEF4444),
              Color(0xFF22C55E),
            ],
          ),
        ),
        Positioned(
          right: -26,
          child: Transform.flip(
            flipX: true,
            child: _Marks(
              colors: const [
                Color(0xFFF59E0B),
                Color(0xFFEF4444),
                Color(0xFF22C55E),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Marks extends StatelessWidget {
  final List<Color> colors;

  const _Marks({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Mark(color: colors[0], rotation: -0.6),
        const SizedBox(height: 6),
        _Mark(color: colors[1], rotation: -0.1),
        const SizedBox(height: 6),
        _Mark(color: colors[2], rotation: 0.4),
      ],
    );
  }
}

class _Mark extends StatelessWidget {
  final Color color;
  final double rotation;

  const _Mark({required this.color, required this.rotation});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: 16,
        height: 4,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
