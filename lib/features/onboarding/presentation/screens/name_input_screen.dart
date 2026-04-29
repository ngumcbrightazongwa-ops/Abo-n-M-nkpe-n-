import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/adaptive_asset_image.dart';
import '../widgets/onboarding_background.dart';
import '../widgets/onboarding_primary_button.dart';

class NameInputScreen extends ConsumerStatefulWidget {
  const NameInputScreen({super.key});

  @override
  ConsumerState<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends ConsumerState<NameInputScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final name = ref.read(onboardingControllerProvider).profile.name;
    _controller = TextEditingController(text: name);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final name = _controller.text.trim();

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
                  stops: [0, 0.55, 1],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.pagePadding),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
                  final headerGap = constraints.maxHeight < 680 ? 12.0 : 18.0;
                  final avatarSize = (constraints.maxHeight * 0.42).clamp(
                    220.0,
                    340.0,
                  );

                  return SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: EdgeInsets.only(bottom: bottomInset),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
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
                                      context.go('/onboarding/welcome');
                                    },
                                    child: const SizedBox(
                                      width: 44,
                                      height: 44,
                                      child: Icon(Icons.chevron_left),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                const _StepIndicator(count: 5, index: 0),
                                const Spacer(),
                                const SizedBox(width: 44, height: 44),
                              ],
                            ),
                            SizedBox(height: headerGap),
                            SizedBox.square(
                              dimension: avatarSize,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryGreen.withAlpha(18),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: ClipOval(
                                  child: const AdaptiveAssetImage(
                                    basePath:
                                        'assets/characters/name_input_hero',
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                    placeholder: AdaptiveAssetImage(
                                      basePath:
                                          'assets/characters/welcome_family',
                                      fit: BoxFit.cover,
                                      alignment: Alignment.topCenter,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: headerGap),
                            const _NameTitle(),
                            const SizedBox(height: 10),
                            Text(
                              'Let’s make this personal.',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodyMuted,
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _controller,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintText: 'Enter your name',
                                prefixIcon: const Icon(Icons.person_outline),
                                prefixIconColor: AppColors.primaryGreen,
                                filled: true,
                                fillColor: AppColors.surface,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: const BorderSide(
                                    color: AppColors.primaryGreen,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: const BorderSide(
                                    color: AppColors.primaryGreen,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: const BorderSide(
                                    color: AppColors.primaryGreen,
                                    width: 2,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                              ),
                              onChanged: (_) => setState(() {}),
                              onSubmitted: (_) => _continue(context),
                            ),
                            const Spacer(),
                            OnboardingPrimaryButton(
                              label: 'Continue',
                              onPressed:
                                  name.isEmpty
                                      ? null
                                      : () => _continue(context),
                            ),
                            const SizedBox(height: 6),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _continue(BuildContext context) async {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    await ref.read(onboardingControllerProvider.notifier).setName(name);
    if (!context.mounted) return;
    context.push('/onboarding/goal');
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
      children: [
        for (var i = 0; i < count; i++) ...[
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 26,
            height: 6,
            decoration: BoxDecoration(
              color: i <= index ? AppColors.primaryGreen : AppColors.border,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          if (i != count - 1) const SizedBox(width: 8),
        ],
      ],
    );
  }
}

class _NameTitle extends StatelessWidget {
  const _NameTitle();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Text(
          'What should\nwe call you?',
          textAlign: TextAlign.center,
          style: AppTextStyles.headline.copyWith(
            fontSize: 34,
            height: 1.06,
            color: AppColors.primaryGreen,
          ),
        ),
        const Positioned(
          left: -30,
          child: _TitleMarks(
            colors: [Color(0xFFF59E0B), Color(0xFFEF4444), Color(0xFF22C55E)],
            flip: true,
          ),
        ),
        const Positioned(
          right: -30,
          child: _TitleMarks(
            colors: [Color(0xFFF59E0B), Color(0xFFEF4444), Color(0xFF22C55E)],
          ),
        ),
      ],
    );
  }
}

class _TitleMarks extends StatelessWidget {
  final List<Color> colors;
  final bool flip;

  const _TitleMarks({required this.colors, this.flip = false});

  @override
  Widget build(BuildContext context) {
    final child = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _TitleMark(color: colors[0], rotation: -0.6),
        const SizedBox(height: 8),
        _TitleMark(color: colors[1], rotation: -0.1),
        const SizedBox(height: 8),
        _TitleMark(color: colors[2], rotation: 0.4),
      ],
    );

    if (!flip) return child;
    return Transform.flip(flipX: true, child: child);
  }
}

class _TitleMark extends StatelessWidget {
  final Color color;
  final double rotation;

  const _TitleMark({required this.color, required this.rotation});

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
