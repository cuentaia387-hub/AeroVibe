import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/glossy_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Real-time clock support
  late DateTime _currentTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _currentTime = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SingleChildScrollView allows scrolling through everything
    return Scaffold(
      backgroundColor: Colors.transparent, // Background handled by Main widget
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(), 
        padding: const EdgeInsets.only(top: 80, left: 24, right: 24, bottom: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 40),
            _buildMainClockCard(),
            const SizedBox(height: 40),
            _buildSectionTitle('Daily Inspiration'),
            const SizedBox(height: 16),
            _buildInspirationCard(),
            const SizedBox(height: 30),
            _buildSectionTitle('Interactive Elements'),
            const SizedBox(height: 16),
            _buildInteractionArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Welcome to the future 👋',
          style: TextStyle(
            fontSize: 18,
            color: AeroColors.mutedText,
            fontWeight: FontWeight.w600,
          ),
        ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2),
        const SizedBox(height: 4),
        ShaderMask(
          shaderCallback: (bounds) => AeroColors.brightSkyGradient.createShader(bounds),
          child: const Text(
            'AeroVibe', 
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w900,
              color: Colors.white, // Required for shader mask
              letterSpacing: -1,
            ),
          ),
        ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1),
      ],
    );
  }

  Widget _buildMainClockCard() {
    final hour = _currentTime.hour.toString().padLeft(2, '0');
    final minute = _currentTime.minute.toString().padLeft(2, '0');
    final second = _currentTime.second.toString().padLeft(2, '0');
    
    // Determine am/pm and 12-hour format loosely
    final amPm = _currentTime.hour >= 12 ? 'PM' : 'AM';
    int displayHour = _currentTime.hour > 12 ? _currentTime.hour - 12 : _currentTime.hour;
    if (displayHour == 0) displayHour = 12;

    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Column(
        children: [
          Icon(
            Icons.access_time_filled_rounded,
            size: 40,
            color: AeroColors.waterBlue.withOpacity(0.8),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true))
           .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 2.seconds),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '$displayHour:$minute',
                style: const TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.w200, // Thin modern font
                  color: AeroColors.waterBlue,
                  letterSpacing: -4,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    amPm,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AeroColors.darkText,
                    ),
                  ),
                  Text(
                    ':$second',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AeroColors.mutedText.withOpacity(0.5),
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Divider(color: AeroColors.glassWhite, thickness: 2),
          const SizedBox(height: 20),
          // A fake "Status" bar that fits the optimism theme
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMiniStatus(Icons.wb_sunny_rounded, 'Mood', 'Sunny', AeroColors.waterBlue),
              Container(width: 1, height: 40, color: AeroColors.glassWhite),
              _buildMiniStatus(Icons.air_rounded, 'Vibe', 'Fresh', AeroColors.natureGreen),
            ],
          ),
        ],
      ),
    ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack);
  }

  Widget _buildMiniStatus(IconData icon, String label, String value, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10, color: AeroColors.mutedText, fontWeight: FontWeight.bold, letterSpacing: 1)),
        Text(value, style: const TextStyle(fontSize: 16, color: AeroColors.darkText, fontWeight: FontWeight.w900)),
      ],
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AeroColors.darkText,
      ),
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _buildInspirationCard() {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.eco_rounded, color: AeroColors.natureGreen, size: 32),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Technology & Nature',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AeroColors.darkText),
                ),
                SizedBox(height: 4),
                Text(
                  'Living in harmony with clean energy and glossy interfaces.',
                  style: TextStyle(color: AeroColors.mutedText, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().slideX(begin: 0.3, delay: 600.ms);
  }

  Widget _buildInteractionArea() {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'This button demonstrates interactive state in the Frutiger Aero aesthetic.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AeroColors.mutedText),
          ),
          const SizedBox(height: 16),
          GlossyButton(
            text: 'Press Me!',
            icon: Icons.touch_app,
            width: double.infinity,
            baseColor: AeroColors.waterBlue,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AeroColors.natureGreen,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  content: const Text('Interaction recorded! Fully functional glossy button.', 
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              );
            },
          ),
        ],
      ),
    ).animate().fadeIn(delay: 800.ms);
  }
}
