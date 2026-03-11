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
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Stack(
            children: [
              // Liquid Distortions (Animated Blobs)
              Positioned.fill(
                child: _LiquidBackground(borderRadius: borderRadius),
              ),
              
              // Glossy Overlay & Inset Shadow simulation
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.4),
                      width: 1.5,
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.2),
                        Colors.white.withOpacity(0.05),
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
        // Blob 1
        _buildBlob(
          color: AeroColors.waterBlue.withOpacity(0.15),
          size: 150,
          begin: const Offset(-0.2, -0.2),
          end: const Offset(0.3, 0.4),
          duration: 4.seconds,
        ),
        // Blob 2
        _buildBlob(
          color: Colors.white.withOpacity(0.1),
          size: 180,
          begin: const Offset(0.8, 0.1),
          end: const Offset(0.4, 0.7),
          duration: 6.seconds,
        ),
        // Blob 3
        _buildBlob(
          color: AeroColors.skyBlue.withOpacity(0.1),
          size: 120,
          begin: const Offset(0.2, 0.8),
          end: const Offset(0.6, 0.2),
          duration: 5.seconds,
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
            begin: Offset(begin.dx * 20, begin.dy * 20),
            end: Offset(end.dx * 20, end.dy * 20),
            duration: duration,
          );
        },
      ),
    );
  }
}
