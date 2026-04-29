import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/adaptive_asset_image.dart';
import '../widgets/onboarding_background.dart';
import '../widgets/onboarding_option_card.dart';
import '../widgets/onboarding_primary_button.dart';

class GoalSelectionScreen extends ConsumerStatefulWidget {
  const GoalSelectionScreen({super.key});

  @override
  ConsumerState<GoalSelectionScreen> createState() =>
      _GoalSelectionScreenState();
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
      ('Speak Nkwen confidently', Icons.chat_bubble_outline),
      ('Understand elders easily', Icons.hearing_outlined),
      ('Learn for family connection', Icons.groups_2_outlined),
      ('Teach my children', Icons.menu_book_outlined),
      ('Improve pronunciation', Icons.graphic_eq),
      ('Just exploring', Icons.explore_outlined),
    ];

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
                            context.go('/onboarding/name');
                          },
                          child: const SizedBox(
                            width: 44,
                            height: 44,
                            child: Icon(Icons.chevron_left),
                          ),
                        ),
                      ),
                      const Spacer(),
                      const _StepIndicator(count: 5, index: 1),
                      const Spacer(),
                      const SizedBox(width: 44, height: 44),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Transform.translate(
                    offset: const Offset(0, -14),
                    child: SizedBox(
                      height: (MediaQuery.sizeOf(context).height * 0.29).clamp(
                        190.0,
                        270.0,
                      ),
                      child: const AdaptiveAssetImage(
                        basePath: 'assets/characters/goal_hero',
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomCenter,
                        placeholder: Center(
                          child: AdaptiveAssetImage(
                            basePath: 'assets/characters/name_input_hero',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const _GoalTitle(),
                  const SizedBox(height: 8),
                  Text(
                    "Tell us what you want to achieve.\nWe’ll personalize your learning.",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMuted,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.only(bottom: 16),
                      itemCount: options.length,
                      separatorBuilder:
                          (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final (title, icon) = options[index];
                        return OnboardingOptionCard(
                          title: title,
                          selected: _selected == title,
                          onTap: () => setState(() => _selected = title),
                          leading: _GoalIcon(icon: icon),
                        );
                      },
                    ),
                  ),
                  OnboardingPrimaryButton(
                    label: 'Continue',
                    onPressed:
                        _selected == null ? null : () => _continue(context),
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

  Future<void> _continue(BuildContext context) async {
    final goal = _selected;
    if (goal == null) return;
    await ref.read(onboardingControllerProvider.notifier).setGoal(goal);
    if (!context.mounted) return;
    context.push('/onboarding/problem');
  }
}

class _GoalIcon extends StatelessWidget {
  final IconData icon;

  const _GoalIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.primaryGreen.withAlpha(18),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: AppColors.primaryGreen),
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

class _GoalTitle extends StatelessWidget {
  const _GoalTitle();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Text(
          'What is your goal?',
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
