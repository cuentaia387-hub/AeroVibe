import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedBubbles extends StatefulWidget {
  final int count;
  const AnimatedBubbles({Key? key, this.count = 20}) : super(key: key);

  @override
  State<AnimatedBubbles> createState() => _AnimatedBubblesState();
}

class _AnimatedBubblesState extends State<AnimatedBubbles> with SingleTickerProviderStateMixin {
  late List<Bubble> bubbles;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    bubbles = List.generate(widget.count, (_) => Bubble());
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 10))
      ..addListener(() => setState(() {}))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer( // VERY IMPORTANT: Let touches pass through!
      child: LayoutBuilder(
        builder: (context, constraints) {
          for (var b in bubbles) {
            b.update(constraints.maxHeight);
          }
          return CustomPaint(
            painter: BubblePainter(bubbles),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class Bubble {
  double x, y;
  double radius;
  double speed;
  double opacity;
  double wobbleOffset;
  double wobbleSpeed;

  Bubble()
      : x = Random().nextDouble() * 400, // starting width (updated in painter)
        y = Random().nextDouble() * 800,
        radius = Random().nextDouble() * 30 + 10,
        speed = Random().nextDouble() * 1.5 + 0.5,
        opacity = Random().nextDouble() * 0.4 + 0.1,
        wobbleOffset = Random().nextDouble() * pi * 2,
        wobbleSpeed = Random().nextDouble() * 0.05 + 0.01;

  void update(double height) {
    y -= speed;
    wobbleOffset += wobbleSpeed;
    if (y < -radius * 2) {
      y = height + radius * 2;
      x = Random().nextDouble() * 400; // Will scale to screen later
    }
  }
}

class BubblePainter extends CustomPainter {
  final List<Bubble> bubbles;

  BubblePainter(this.bubbles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var b in bubbles) {
      // Scale x based on current screen width
      double drawX = (b.x / 400) * size.width;
      // apply wobble
      drawX += sin(b.wobbleOffset) * 20;

      // Draw the glass bubble
      paint.shader = RadialGradient(
        colors: [
          Colors.white.withOpacity(b.opacity * 1.5), // Inner highlight
          Colors.white.withOpacity(0.0),             // Transparent edges
        ],
        stops: const [0.1, 1.0],
      ).createShader(Rect.fromCircle(center: Offset(drawX, b.y), radius: b.radius));

      canvas.drawCircle(Offset(drawX, b.y), b.radius, paint);

      // Draw sharp top gloss
      final glossPaint = Paint()
        ..color = Colors.white.withOpacity(b.opacity * 2)
        ..style = PaintingStyle.fill;
      
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(drawX, b.y - b.radius * 0.5),
          width: b.radius * 0.8,
          height: b.radius * 0.3,
        ),
        glossPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
