import 'package:flutter/material.dart';

import '../../../../app/constants/app_strings.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';

class MeaningBreakdownCard extends StatelessWidget {
  final String text;

  const MeaningBreakdownCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.meaningBreakdownTitle, style: AppTextStyles.title),
                const SizedBox(height: 8),
                Text(text, style: AppTextStyles.bodyMuted),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withAlpha(31),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.lightbulb_outline, color: AppColors.primaryGreen, size: 20),
          ),
        ],
      ),
    );
  }
}
