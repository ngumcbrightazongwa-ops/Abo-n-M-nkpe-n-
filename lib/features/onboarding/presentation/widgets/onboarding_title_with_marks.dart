import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class OnboardingTitleWithMarks extends StatelessWidget {
  final String title;

  const OnboardingTitleWithMarks({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Text(
          title,
          style: AppTextStyles.headline.copyWith(
            fontSize: 34,
            color: AppColors.primaryGreen,
          ),
          textAlign: TextAlign.center,
        ),
        Positioned(
          left: -26,
          child: _Marks(
            colors: const [
              Color(0xFFF59E0B),
              Color(0xFFEF4444),
              Color(0xFF22C55E),
            ],
          ),
        ),
        Positioned(
          right: -26,
          child: Transform.flip(
            flipX: true,
            child: _Marks(
              colors: const [
                Color(0xFFF59E0B),
                Color(0xFFEF4444),
                Color(0xFF22C55E),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Marks extends StatelessWidget {
  final List<Color> colors;

  const _Marks({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Mark(color: colors[0], rotation: -0.6),
        const SizedBox(height: 6),
        _Mark(color: colors[1], rotation: -0.1),
        const SizedBox(height: 6),
        _Mark(color: colors[2], rotation: 0.4),
      ],
    );
  }
}

class _Mark extends StatelessWidget {
  final Color color;
  final double rotation;

  const _Mark({required this.color, required this.rotation});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: 16,
        height: 4,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

