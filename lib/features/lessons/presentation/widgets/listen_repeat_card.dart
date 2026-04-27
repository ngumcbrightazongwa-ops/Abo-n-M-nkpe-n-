import 'package:flutter/material.dart';

import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/audio_button.dart';

class ListenRepeatCard extends StatelessWidget {
  final VoidCallback? onListen;

  const ListenRepeatCard({super.key, required this.onListen});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Listen & repeat', style: AppTextStyles.title),
          const SizedBox(height: 6),
          Text(
            'Tap listen, then say it out loud.',
            style: AppTextStyles.bodyMuted,
          ),
          const SizedBox(height: 12),
          AudioButton(onPressed: onListen),
        ],
      ),
    );
  }
}

