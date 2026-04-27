import 'package:flutter/material.dart';

import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';

class WordCard extends StatelessWidget {
  final String word;
  final String pronunciation;
  final String meaning;
  final String category;

  const WordCard({
    super.key,
    required this.word,
    required this.pronunciation,
    required this.meaning,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(category.toUpperCase(), style: AppTextStyles.caption),
          const SizedBox(height: 10),
          Text(word, style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Text('Pronunciation: $pronunciation', style: AppTextStyles.bodyMuted),
          const SizedBox(height: 6),
          Text('Meaning: $meaning', style: AppTextStyles.body),
        ],
      ),
    );
  }
}

