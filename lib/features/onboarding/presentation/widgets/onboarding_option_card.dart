import 'package:flutter/material.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class OnboardingOptionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool selected;
  final VoidCallback? onTap;
  final Widget? leading;

  const OnboardingOptionCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.selected,
    required this.onTap,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    final trailing = selected
        ? Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: AppColors.primaryGreen,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.check,
                size: 16,
                color: Colors.white,
              ),
            ),
          )
        : Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primaryGreen,
                width: 2,
              ),
            ),
          );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: selected ? AppColors.primaryGreen.withAlpha(18) : AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(
          color: selected ? AppColors.primaryGreen : AppColors.border,
          width: selected ? 2 : 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.cardPadding),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.title),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(subtitle!, style: AppTextStyles.bodyMuted),
                    ],
                  ],
                ),
              ),
              AnimatedScale(
                duration: const Duration(milliseconds: 200),
                scale: selected ? 1 : 0.9,
                child: trailing,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
