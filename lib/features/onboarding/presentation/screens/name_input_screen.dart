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
import '../widgets/onboarding_character.dart';

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
      backgroundColor: AppColors.background,
      body: OnboardingBackground(
        child: SafeArea(
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
                        onTap: () => context.pop(),
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
                const SizedBox(height: 18),
                SizedBox.square(
                  dimension: 260,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryGreen.withAlpha(18),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: ClipOval(
                      child: const AdaptiveAssetImage(
                        basePath: 'assets/characters/welcome_family',
                        fit: BoxFit.cover,
                        alignment: Alignment(0, -0.7),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'What should\nwe call you?',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.headline.copyWith(
                    fontSize: 34,
                    height: 1.06,
                    color: AppColors.primaryGreen,
                  ),
                ),
                const SizedBox(height: 8),
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
                  onPressed: name.isEmpty ? null : () => _continue(context),
                ),
                const SizedBox(height: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _continue(BuildContext context) async {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    await ref.read(onboardingControllerProvider.notifier).setName(name);
    if (!context.mounted) return;
    context.go('/onboarding/goal');
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
