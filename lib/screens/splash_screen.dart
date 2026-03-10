import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../theme/app_theme.dart';
import '../widgets/bubble_painter.dart';
import 'home_screen.dart'; // Just for routing logic later, but actually handled in main
import 'dart:async';

class SplashScreen extends StatefulWidget {
  final VoidCallback onComplete;
  
  const SplashScreen({Key? key, required this.onComplete}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Proceed to app after 3.5 seconds
    Timer(const Duration(milliseconds: 3500), () {
      widget.onComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AeroColors.waterBlue,
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            // Very bright sky background
            gradient: AeroColors.brightSkyGradient,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
            // Floating bubbles in background
            const Positioned.fill(child: AnimatedBubbles(count: 15)),
            
            // Concentric rings pulsing
            FadeIn(
              duration: const Duration(milliseconds: 1000),
              child: CustomPaint(
                size: const Size(250, 250),
                painter: _RingPainter(),
              ),
            ),
            
            // Main Logo
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ZoomIn(
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.easeOutBack,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.9),
                      boxShadow: [
                        BoxShadow(
                          color: AeroColors.waterBlue.withOpacity(0.4),
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                      ],
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: ShaderMask(
                      shaderCallback: (bounds) => AeroColors.brightSkyGradient.createShader(bounds),
                      child: const Icon(
                        Icons.eco_rounded,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FadeInUp(
                  delay: const Duration(milliseconds: 800),
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [AeroColors.waterBlue, AeroColors.natureGreen],
                    ).createShader(bounds),
                    child: const Text(
                      'AeroVibe',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.5,
                        color: Colors.white, // Required for shader mask
                      ),
                    ),
                  ),
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 1000),
                  child: const Text(
                    'OPTIMISM & NATURE',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                      color: AeroColors.darkText,
                    ),
                  ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;
    
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 1.0;

    for (int i = 1; i <= 4; i++) {
      canvas.drawCircle(center, maxRadius * (i / 4), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
