import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class LiquidGlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  const LiquidGlassCard({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.borderRadius = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Stack(
            children: [
              // 1. Animated Liquid Waves (Inner Background)
              Positioned.fill(
                child: _LiquidBackground(borderRadius: borderRadius),
              ),

              // 2. Noise Grain Overlay (Custom Painter)
              Positioned.fill(
                child: CustomPaint(
                  painter: _NoisePainter(opacity: 0.03),
                ),
              ),
              
              // 3. Ultra-Transparent Glass Layer
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.05), // Refined transparency
                        Colors.white.withOpacity(0.01),
                      ],
                    ),
                  ),
                ),
              ),

              // 4. Sharp Specular Highlights (Top & Left Edges)
              _buildSpecularBorders(),

              // 5. Content
              Padding(
                padding: padding ?? const EdgeInsets.all(24.0),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecularBorders() {
    return Positioned.fill(
      child: CustomPaint(
        painter: _SpecularBorderPainter(borderRadius: borderRadius),
      ),
    );
  }
}

class _SpecularBorderPainter extends CustomPainter {
  final double borderRadius;
  _SpecularBorderPainter({required this.borderRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0.5, 0.5, size.width - 1, size.height - 1),
      Radius.circular(borderRadius),
    );

    // Top-Left highlight (Light coming from top-left)
    paint.shader = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.white.withOpacity(0.5),
        Colors.white.withOpacity(0.2),
        Colors.white.withOpacity(0.0),
      ],
      stops: const [0.0, 0.3, 0.6],
    ).createShader(rrect.outerRect);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _NoisePainter extends CustomPainter {
  final double opacity;
  _NoisePainter({required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(opacity);
    final random = math.Random(42); // Deterministic noise
    
    // Draw tiny "noise" dots
    for (int i = 0; i < 1500; i++) {
      final dx = random.nextDouble() * size.width;
      final dy = random.nextDouble() * size.height;
      canvas.drawCircle(Offset(dx, dy), 0.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LiquidBackground extends StatelessWidget {
  final double borderRadius;
  const _LiquidBackground({Key? key, required this.borderRadius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Wave 1 - Deeper Blue
        _buildWave(
          color: AeroColors.waterBlue.withOpacity(0.4),
          size: 300,
          begin: const Offset(-0.4, -0.4),
          end: const Offset(0.2, 0.2),
          duration: 6.seconds,
        ),
        // Wave 2 - Lighter Sky Blue
        _buildWave(
          color: AeroColors.skyBlue.withOpacity(0.35),
          size: 350,
          begin: const Offset(0.9, 0.1),
          end: const Offset(0.4, 0.7),
          duration: 8.seconds,
        ),
        // Wave 3 - Soft White Glow
        _buildWave(
          color: Colors.white.withOpacity(0.2),
          size: 250,
          begin: const Offset(0.1, 0.8),
          end: const Offset(0.7, 0.3),
          duration: 7.seconds,
        ),
      ],
    );
  }

  Widget _buildWave({
    required Color color,
    required double size,
    required Offset begin,
    required Offset end,
    required Duration duration,
  }) {
    return Positioned.fill(
      child: AnimatedAlign(
        duration: duration,
        curve: Curves.easeInOutSine,
        alignment: Alignment(begin.dx, begin.dy),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [color, color.withOpacity(0)],
            ),
          ),
        ),
      ).animate(onPlay: (c) => c.repeat(reverse: true)).move(
        begin: Offset(begin.dx * 40, begin.dy * 40),
        end: Offset(end.dx * 40, end.dy * 40),
        duration: duration,
      ).scale(
        begin: const Offset(0.7, 0.7),
        end: const Offset(1.3, 1.3),
        duration: (duration.inMilliseconds * 0.8).toInt().milliseconds,
      ),
    );
  }
}
