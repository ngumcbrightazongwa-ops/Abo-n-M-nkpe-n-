import 'package:flutter/material.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/audio_waveform.dart';

class OnboardingAudioCard extends StatelessWidget {
  final VoidCallback? onPressed;

  const OnboardingAudioCard({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    const bars = [
      0.25,
      0.5,
      0.35,
      0.7,
      0.45,
      0.3,
      0.55,
      0.25,
      0.6,
      0.4,
      0.75,
      0.5,
      0.25,
      0.45,
      0.65,
      0.35,
      0.55,
      0.25,
      0.6,
      0.4,
      0.7,
      0.3,
      0.55,
      0.25,
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSizes.cardPadding),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryGreen.withOpacity(0.12),
                ),
                child: const Icon(Icons.volume_up, color: AppColors.primaryGreen),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Listen to this phrase', style: AppTextStyles.title),
                    const SizedBox(height: 2),
                    Text('Nkwen audio', style: AppTextStyles.bodyMuted),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              SizedBox(
                width: 52,
                height: 52,
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: EdgeInsets.zero,
                    backgroundColor: AppColors.primaryGreen,
                    foregroundColor: Colors.white,
                  ),
                  child: const Icon(Icons.play_arrow, size: 26),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: AudioWaveform(
                  bars: bars,
                  color: AppColors.primaryGreen,
                  height: 26,
                  barWidth: 4,
                  gap: 3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

