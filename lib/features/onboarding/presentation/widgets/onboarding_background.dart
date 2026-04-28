import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class OnboardingBackground extends StatelessWidget {
  final Widget child;

  const OnboardingBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DiamondPatternPainter(),
      child: child,
    );
  }
}

class _DiamondPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final color = AppColors.border.withAlpha(89);
    paint.color = color;

    const spacing = 78.0;
    final cols = (size.width / spacing).ceil() + 2;
    final rows = (size.height / spacing).ceil() + 2;

    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < cols; c++) {
        final x = (c * spacing) + (r.isEven ? 0 : spacing / 2);
        final y = r * spacing;
        final s = 18 + (sin((c + r) * 0.9) + 1) * 5;
        final path = Path()
          ..moveTo(x, y - s)
          ..lineTo(x + s, y)
          ..lineTo(x, y + s)
          ..lineTo(x - s, y)
          ..close();
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

