import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/liquid_glass_card.dart';
import '../widgets/glossy_button.dart';
import '../widgets/aero_icons.dart';

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
            _buildSectionTitle('Inspiración Diaria'),
            const SizedBox(height: 16),
            _buildInspirationCard(),
            const SizedBox(height: 30),
            _buildSectionTitle('Elementos Interactivos'),
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
          'Bienvenido al futuro 👋',
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

    return LiquidGlassCard(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Column(
        children: [
          const AeroClockIcon(size: 60)
            .animate(onPlay: (controller) => controller.repeat(reverse: true))
            .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 3.seconds),
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
                  fontWeight: FontWeight.w400, // Slightly bolder as requested
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
              _buildMiniStatus(Icons.wb_sunny_rounded, 'Humor', 'Soleado', AeroColors.waterBlue),
              Container(width: 1, height: 40, color: AeroColors.glassWhite),
              _buildMiniStatus(Icons.air_rounded, 'Vibra', 'Fresco', AeroColors.natureGreen),
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
                  'Tecnología y Naturaleza',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AeroColors.darkText),
                ),
                SizedBox(height: 4),
                Text(
                  'Viviendo en armonía con energía limpia e interfaces brillantes.',
                  style: TextStyle(color: AeroColors.mutedText, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().slideX(begin: 0.3, delay: 600.ms);
  }

  bool _isQuoteRevealed = false;

  Widget _buildInteractionArea() {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutBack,
        child: Column(
          children: [
            Text(
              _isQuoteRevealed 
                ? 'El secreto del diseño Aero'
                : 'Descubre más sobre este estilo',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AeroColors.darkText,
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
            const SizedBox(height: 16),
            if (!_isQuoteRevealed) ...[
              const Text(
                'Presiona el botón para revelar un dato curioso sobre la estética Frutiger Aero.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AeroColors.mutedText, fontSize: 13),
              ),
              const SizedBox(height: 16),
              GlossyButton(
                text: 'Revelar Dato',
                icon: Icons.auto_awesome,
                width: double.infinity,
                baseColor: AeroColors.waterBlue,
                onPressed: () {
                  setState(() {
                    _isQuoteRevealed = true;
                  });
                },
              ),
            ] else ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white.withOpacity(0.8)),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.format_quote_rounded, color: AeroColors.waterBlue, size: 30),
                    SizedBox(height: 8),
                    Text(
                      'El Frutiger Aero (2004-2013) se caracterizaba por su optimismo corporativo, skeuomorfismo excesivo, texturas brillantes, fotografías de naturaleza (especialmente agua y hierba), bolitas de cristal y auroras. Representaba un futuro donde la tecnología y la naturaleza coexistían en perfecta armonía fluida.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: AeroColors.darkText,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
              const SizedBox(height: 16),
              GlossyButton(
                text: 'Ocultar',
                icon: Icons.visibility_off,
                width: double.infinity,
                baseColor: AeroColors.mutedText,
                onPressed: () {
                  setState(() {
                    _isQuoteRevealed = false;
                  });
                },
              ),
            ],
          ],
        ),
      ),
    ).animate().fadeIn(delay: 800.ms);
  }
}
