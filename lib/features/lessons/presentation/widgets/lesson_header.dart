import 'package:flutter/material.dart';

import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/progress_bar.dart';

class LessonHeader extends StatelessWidget {
  final String title;
  final double progress;

  const LessonHeader({super.key, required this.title, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.headline),
        const SizedBox(height: 12),
        ProgressBar(progress: progress),
      ],
    );
  }
}

