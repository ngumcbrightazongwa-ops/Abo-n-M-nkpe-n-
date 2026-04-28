import 'package:flutter/material.dart';

class AudioWaveform extends StatelessWidget {
  final List<double> bars;
  final Color color;
  final double height;
  final double barWidth;
  final double gap;
  final BorderRadius borderRadius;

  const AudioWaveform({
    super.key,
    required this.bars,
    required this.color,
    this.height = 22,
    this.barWidth = 3,
    this.gap = 2,
    this.borderRadius = const BorderRadius.all(Radius.circular(999)),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var i = 0; i < bars.length; i++) ...[
            Container(
              width: barWidth,
              height: (height * bars[i]).clamp(2, height),
              decoration: BoxDecoration(
                color: color,
                borderRadius: borderRadius,
              ),
            ),
            if (i != bars.length - 1) SizedBox(width: gap),
          ],
        ],
      ),
    );
  }
}
