import 'package:flutter/material.dart';

import '../../../../app/constants/app_strings.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class PracticeOptions extends StatelessWidget {
  final List<String> options;

  const PracticeOptions({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.letsPracticeTitle, style: AppTextStyles.title),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (var i = 0; i < options.length; i++)
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 120),
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.volume_up, size: 18),
                  label: Text(options[i]),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: i == 0 ? AppColors.primaryGreen : AppColors.textPrimary,
                    backgroundColor: i == 0 ? AppColors.primaryGreen.withAlpha(20) : AppColors.surface,
                    side: BorderSide(color: i == 0 ? AppColors.primaryGreen : AppColors.border),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    textStyle: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
