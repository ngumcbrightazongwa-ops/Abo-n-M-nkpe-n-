import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final topInset = MediaQuery.paddingOf(context).top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.surface,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: Stack(
          children: [
            OnboardingBackground(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.pagePadding),
                  child: Column(
                    children: [
                      const _WelcomeHeader(),
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
                                    const SizedBox(height: 18),
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
                        onPressed: () => context.push('/onboarding/name'),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
            if (topInset > 0)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: topInset,
                child: const ColoredBox(color: AppColors.surface),
              ),
          ],
        ),
      ),
    );
  }
}

class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final headerHeight = (screenSize.height * 0.52).clamp(300.0, 460.0);

    return SizedBox(
      height: headerHeight,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          const Positioned.fill(child: ColoredBox(color: AppColors.surface)),
          Positioned.fill(
            child: OverflowBox(
              alignment: Alignment.topCenter,
              maxWidth: double.infinity,
              child: SizedBox(
                width: screenSize.width,
                child: ClipPath(
                  clipper: _BottomArcClipper(),
                  child: Transform.translate(
                    offset: const Offset(0, 18),
                    child: const AdaptiveAssetImage(
                      basePath: 'assets/characters/welcome_family',
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      fadeBottom: true,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AdaptiveAssetImage(
                  basePath: 'assets/images/nkwen_logo',
                  height: 148,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
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
          left: -30,
          child: _Marks(
            colors: const [
              Color(0xFFF59E0B),
              Color(0xFFEF4444),
              Color(0xFF22C55E),
            ],
          ),
        ),
        Positioned(
          right: -30,
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
        const SizedBox(height: 8),
        _Mark(color: colors[1], rotation: -0.1),
        const SizedBox(height: 8),
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
        width: 20,
        height: 5,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}

class _BottomArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final arcHeight = size.height * 0.22;
    return Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height - arcHeight)
      ..quadraticBezierTo(
        size.width / 2,
        size.height + arcHeight,
        size.width,
        size.height - arcHeight,
      )
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
