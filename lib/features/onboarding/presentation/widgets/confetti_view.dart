import 'dart:math';

import 'package:flutter/material.dart';

class ConfettiView extends StatefulWidget {
  final bool enabled;

  const ConfettiView({super.key, required this.enabled});

  @override
  State<ConfettiView> createState() => _ConfettiViewState();
}

class _ConfettiViewState extends State<ConfettiView> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_ConfettiParticle> _particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))
      ..repeat();
    _particles = List.generate(70, (index) => _ConfettiParticle.random(Random(index * 37)));
  }

  @override
  void didUpdateWidget(covariant ConfettiView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.enabled && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return const SizedBox.shrink();

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _ConfettiPainter(
              t: _controller.value,
              particles: _particles,
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class _ConfettiParticle {
  final double x;
  final double size;
  final double speed;
  final double drift;
  final Color color;

  const _ConfettiParticle({
    required this.x,
    required this.size,
    required this.speed,
    required this.drift,
    required this.color,
  });

  factory _ConfettiParticle.random(Random random) {
    const colors = [
      Color(0xFF22C55E),
      Color(0xFF3B82F6),
      Color(0xFFF97316),
      Color(0xFFEC4899),
      Color(0xFFEAB308),
    ];
    return _ConfettiParticle(
      x: random.nextDouble(),
      size: 4 + random.nextDouble() * 6,
      speed: 0.6 + random.nextDouble() * 1.1,
      drift: (random.nextDouble() - 0.5) * 0.5,
      color: colors[random.nextInt(colors.length)],
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  final double t;
  final List<_ConfettiParticle> particles;

  _ConfettiPainter({required this.t, required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final h = size.height;
    final w = size.width;

    for (final p in particles) {
      final y = (t * p.speed * h * 1.4 + p.size * 10) % (h + 60) - 60;
      final x = (p.x * w) + sin((t * 2 * pi) + p.x * 4) * (w * p.drift * 0.05);
      paint.color = p.color;
      canvas.drawCircle(Offset(x, y), p.size / 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) {
    return oldDelegate.t != t;
  }
}
