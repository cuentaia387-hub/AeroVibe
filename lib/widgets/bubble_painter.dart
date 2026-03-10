import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/weather_data.dart';

class BubblePainter extends CustomPainter {
  final List<AeroParticle> particles;
  final Animation<double> animation;

  BubblePainter({required this.particles, required this.animation})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final phase = (animation.value + p.x / size.width) % 1.0;
      final y = p.y - phase * size.height * 0.3;
      final x = p.x + math.sin(phase * math.pi * 2) * 20;

      // Outer glow
      final glowPaint = Paint()
        ..color = p.color.withOpacity(p.opacity * 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);
      canvas.drawCircle(Offset(x, y), p.radius * 1.5, glowPaint);

      // Bubble body
      final bodyPaint = Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.3, -0.3),
          radius: 1.0,
          colors: [
            Colors.white.withOpacity(p.opacity * 0.6),
            p.color.withOpacity(p.opacity * 0.4),
            p.color.withOpacity(p.opacity * 0.1),
          ],
        ).createShader(Rect.fromCircle(center: Offset(x, y), radius: p.radius));
      canvas.drawCircle(Offset(x, y), p.radius, bodyPaint);

      // Gloss highlight (top-left spot)
      final glossPaint = Paint()
        ..color = Colors.white.withOpacity(p.opacity * 0.7)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
      canvas.drawCircle(
        Offset(x - p.radius * 0.3, y - p.radius * 0.3),
        p.radius * 0.25,
        glossPaint,
      );

      // Secondary highlight
      final glossPaint2 = Paint()
        ..color = Colors.white.withOpacity(p.opacity * 0.4);
      canvas.drawCircle(
        Offset(x - p.radius * 0.15, y - p.radius * 0.15),
        p.radius * 0.12,
        glossPaint2,
      );
    }
  }

  @override
  bool shouldRepaint(BubblePainter oldDelegate) => true;
}

class AnimatedBubbles extends StatefulWidget {
  final int count;
  final Widget child;

  const AnimatedBubbles({
    super.key,
    this.count = 20,
    required this.child,
  });

  @override
  State<AnimatedBubbles> createState() => _AnimatedBubblesState();
}

class _AnimatedBubblesState extends State<AnimatedBubbles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<AeroParticle> _particles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initParticles(Size size) {
    if (_particles.isEmpty) {
      _particles = List.generate(
        widget.count,
        (_) => AeroParticle.random(size),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final size = Size(constraints.maxWidth, constraints.maxHeight);
      _initParticles(size);
      return Stack(
        children: [
          widget.child,
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return CustomPaint(
                painter: BubblePainter(
                  particles: _particles,
                  animation: _controller,
                ),
                child: const SizedBox.expand(),
              );
            },
          ),
        ],
      );
    });
  }
}
