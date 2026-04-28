import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../../app/constants/app_strings.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/audio_waveform.dart';

class ListenRepeatCard extends StatelessWidget {
  final VoidCallback? onListen;
  final VoidCallback? onToggleRecording;
  final bool isRecording;

  const ListenRepeatCard({
    super.key,
    required this.onListen,
    required this.onToggleRecording,
    required this.isRecording,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.listenAndRepeatTitle, style: AppTextStyles.title),
          const SizedBox(height: 12),
          Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(999),
                onTap: onListen,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.primaryGreen.withAlpha(31),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.volume_up, color: AppColors.primaryGreen, size: 18),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AudioWaveform(
                  bars: const [0.2, 0.55, 0.35, 0.8, 0.45, 0.25, 0.65, 0.35, 0.75, 0.4, 0.6, 0.3],
                  color: AppColors.primaryGreen.withAlpha(120),
                  height: 22,
                  barWidth: 3,
                  gap: 3,
                ),
              ),
              const SizedBox(width: 12),
              Row(
                children: [
                  const Icon(CupertinoIcons.tortoise, size: 18, color: AppColors.primaryGreen),
                  const SizedBox(width: 6),
                  Text(AppStrings.slowLabel, style: AppTextStyles.bodyMuted),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withAlpha(26),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.primaryGreen.withAlpha(46)),
            ),
            child: Column(
              children: [
                Text(
                  AppStrings.yourTurnTitle,
                  style: AppTextStyles.title.copyWith(color: AppColors.primaryGreen),
                ),
                const SizedBox(height: 6),
                Text(
                  AppStrings.tapMicInstruction,
                  style: AppTextStyles.bodyMuted,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AudioWaveform(
                      bars: const [0.25, 0.5, 0.35, 0.65, 0.4],
                      color: AppColors.primaryGreen.withAlpha(89),
                      height: 16,
                      barWidth: 3,
                      gap: 3,
                    ),
                    const SizedBox(width: 14),
                    InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: onToggleRecording,
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryGreen,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isRecording ? Icons.stop_rounded : Icons.mic,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    AudioWaveform(
                      bars: const [0.3, 0.65, 0.35, 0.55, 0.25],
                      color: AppColors.primaryGreen.withAlpha(89),
                      height: 16,
                      barWidth: 3,
                      gap: 3,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
