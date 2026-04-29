import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';

class OnboardingProgressHeader extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const OnboardingProgressHeader({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    final before = (currentStep - 1).clamp(0, totalSteps);
    final after = (totalSteps - currentStep).clamp(0, totalSteps);

    return Row(
      children: [
        _BackButton(onPressed: () => context.pop()),
        const SizedBox(width: 14),
        Expanded(
          child: Row(
            children: [
              for (var i = 0; i < before; i++) ...[
                const Expanded(child: _Segment(active: true)),
                const SizedBox(width: 8),
              ],
              _StepBadge(step: currentStep),
              if (after > 0) ...[
                const SizedBox(width: 8),
                for (var i = 0; i < after; i++) ...[
                  const Expanded(child: _Segment(active: false)),
                  if (i != after - 1) const SizedBox(width: 8),
                ],
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _Segment extends StatelessWidget {
  final bool active;

  const _Segment({required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      decoration: BoxDecoration(
        color: active ? AppColors.primaryGreen : AppColors.border,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}

class _StepBadge extends StatelessWidget {
  final int step;

  const _StepBadge({required this.step});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryGreen,
      ),
      child: Center(
        child: Text(
          '$step',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _BackButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const CircleBorder(),
      elevation: 1,
      shadowColor: AppColors.shadow,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: const SizedBox(
          width: 44,
          height: 44,
          child: Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}

