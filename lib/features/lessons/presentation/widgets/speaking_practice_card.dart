import 'package:flutter/material.dart';

import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';

class SpeakingPracticeCard extends StatelessWidget {
  final bool isRecording;
  final VoidCallback? onRequestPermission;
  final VoidCallback? onToggleRecording;

  const SpeakingPracticeCard({
    super.key,
    required this.isRecording,
    required this.onRequestPermission,
    required this.onToggleRecording,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Speaking practice', style: AppTextStyles.title),
          const SizedBox(height: 6),
          Text(
            'We will add speech recognition later. For now, you can record audio as a placeholder.',
            style: AppTextStyles.bodyMuted,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              OutlinedButton.icon(
                onPressed: onRequestPermission,
                icon: const Icon(Icons.mic_none),
                label: const Text('Allow mic'),
              ),
              FilledButton.icon(
                onPressed: onToggleRecording,
                icon: Icon(isRecording ? Icons.stop_circle_outlined : Icons.mic),
                label: Text(isRecording ? 'Stop' : 'Record'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

