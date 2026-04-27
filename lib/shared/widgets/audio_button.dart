import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

class AudioButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? label;

  const AudioButton({super.key, required this.onPressed, this.label});

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      onPressed: onPressed,
      icon: const Icon(Icons.volume_up, color: AppColors.accentBlue),
      label: Text(label ?? 'Listen'),
    );
  }
}
