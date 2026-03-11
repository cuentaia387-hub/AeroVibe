import 'dart:ui';
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
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Stack(
            children: [
              // Liquid Distortions (Animated Blobs) - NOW MORE VIBRANT
              Positioned.fill(
                child: _LiquidBackground(borderRadius: borderRadius),
              ),
              
              // Glossy Overlay & Inset Shadow simulation - MORE TRANSLUCENT
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1.0,
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.08),
                        Colors.white.withOpacity(0.02),
                      ],
                    ),
                  ),
                ),
              ),

              // Content
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
}

class _LiquidBackground extends StatelessWidget {
  final double borderRadius;
  const _LiquidBackground({Key? key, required this.borderRadius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blob 1 - Watery Blue
        _buildBlob(
          color: AeroColors.waterBlue.withOpacity(0.3),
          size: 200,
          begin: const Offset(-0.3, -0.3),
          end: const Offset(0.4, 0.5),
          duration: 3.seconds,
        ),
        // Blob 2 - Pure White Highlight
        _buildBlob(
          color: Colors.white.withOpacity(0.15),
          size: 250,
          begin: const Offset(0.7, -0.2),
          end: const Offset(0.2, 0.8),
          duration: 5.seconds,
        ),
        // Blob 3 - Sky Blue Depth
        _buildBlob(
          color: AeroColors.skyBlue.withOpacity(0.2),
          size: 180,
          begin: const Offset(0.1, 0.9),
          end: const Offset(0.8, 0.3),
          duration: 4.seconds,
        ),
      ],
    );
  }

  Widget _buildBlob({
    required Color color,
    required double size,
    required Offset begin,
    required Offset end,
    required Duration duration,
  }) {
    return Positioned.fill(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return AnimatedAlign(
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
            begin: Offset(begin.dx * 30, begin.dy * 30),
            end: Offset(end.dx * 30, end.dy * 30),
            duration: duration,
          ).scale(
            begin: const Offset(0.8, 0.8),
            end: const Offset(1.2, 1.2),
            duration: duration,
          );
        },
      ),
    );
  }
}
