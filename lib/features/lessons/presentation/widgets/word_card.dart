import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';

class WordCard extends StatelessWidget {
  final String word;
  final String pronunciation;
  final String meaning;
  final VoidCallback? onPlay;
  final VoidCallback? onToggleFavorite;

  const WordCard({
    super.key,
    required this.word,
    required this.pronunciation,
    required this.meaning,
    required this.onPlay,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child: const Icon(Icons.person, size: 34, color: AppColors.textSecondary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        word,
                        style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w800),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                      onPressed: onToggleFavorite,
                      icon: const Icon(Icons.favorite_border),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: onPlay,
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(Icons.volume_up, size: 20, color: AppColors.primaryGreen),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text('($pronunciation)', style: AppTextStyles.bodyMuted),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(height: 1, color: AppColors.border),
                const SizedBox(height: 10),
                Text(meaning, style: AppTextStyles.body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
