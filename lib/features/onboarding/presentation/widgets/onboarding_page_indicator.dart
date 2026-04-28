import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class OnboardingPageIndicator extends StatelessWidget {
  final int count;
  final int index;

  const OnboardingPageIndicator({
    super.key,
    required this.count,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? AppColors.primaryGreen : AppColors.border,
          ),
        );
      }),
    );
  }
}

