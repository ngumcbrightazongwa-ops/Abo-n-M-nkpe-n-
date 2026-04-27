import 'package:flutter/material.dart';

import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';

class PracticeOptions extends StatelessWidget {
  final List<String> options;

  const PracticeOptions({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Practice options', style: AppTextStyles.title),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final option in options) Chip(label: Text(option)),
            ],
          ),
        ],
      ),
    );
  }
}

