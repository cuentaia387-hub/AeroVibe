import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/glossy_button.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Uses Main's background
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 20),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Discover Nature',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: AeroColors.darkText,
                    ),
                  ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.1),
                  const SizedBox(height: 8),
                  const Text(
                    'Experience the harmony of Frutiger Aero',
                    style: TextStyle(
                      fontSize: 16,
                      color: AeroColors.mutedText,
                      fontWeight: FontWeight.w600,
                    ),
                  ).animate().fadeIn(delay: 200.ms),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildNatureCard(context, index)
                      .animate()
                      .scale(delay: (100 * index).ms, duration: 400.ms, curve: Curves.easeOutBack);
                },
                childCount: _natureItems.length,
              ),
            ),
          ),
          // Add bottom padding so last items aren't hidden by nav bar
          const SliverPadding(padding: EdgeInsets.only(bottom: 120)),
        ],
      ),
    );
  }

  Widget _buildNatureCard(BuildContext context, int index) {
    final item = _natureItems[index];

    return GlassCard(
      padding: EdgeInsets.zero,
      onTap: () => _showDetailSheet(context, item),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Simulated image area (gradients mimicking nature)
          Container(
            decoration: BoxDecoration(
              gradient: item.gradient,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          // White gloss overlay over the "image"
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x66FFFFFF), Colors.transparent],
                stops: [0.0, 0.5],
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(item.icon, color: item.iconColor, size: 24),
                ),
                const SizedBox(height: 12),
                Text(
                  item.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    shadows: [Shadow(color: Colors.black45, blurRadius: 4, offset: Offset(0, 2))],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDetailSheet(BuildContext context, _NatureItem item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => GlassCard(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40, height: 5,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Icon(item.icon, size: 40, color: item.iconColor),
                const SizedBox(width: 16),
                Text(
                  item.title,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AeroColors.darkText),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              item.description,
              style: const TextStyle(fontSize: 16, color: AeroColors.mutedText, height: 1.5),
            ),
            const SizedBox(height: 32),
            GlossyButton(
              text: 'View Collection',
              icon: Icons.photo_library,
              width: double.infinity,
              baseColor: item.iconColor,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _NatureItem {
  final String title;
  final IconData icon;
  final Color iconColor;
  final LinearGradient gradient;
  final String description;

  const _NatureItem(this.title, this.icon, this.iconColor, this.gradient, this.description);
}

const List<_NatureItem> _natureItems = [
  _NatureItem(
    'Ocean Depths', Icons.water, AeroColors.waterBlue,
    LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AeroColors.skyBlue, Color(0xFF0277BD)]),
    'Crystal clear aquatic life and pure water textures representing the fluidity of the Aero design language.'
  ),
  _NatureItem(
    'Lush Fields', Icons.grass, AeroColors.grassGreen,
    AeroColors.freshGrassGradient,
    'Rolling green hills and bright skies. A staple of mid-2000s desktop backgrounds.'
  ),
  _NatureItem(
    'Clear Skies', Icons.cloud, AeroColors.skyBlue,
    AeroColors.brightSkyGradient,
    'Optimistic open skies with fluffy clouds and lens flares highlighting the forward-thinking technology era.'
  ),
  _NatureItem(
    'Glass Bubbles', Icons.bubble_chart, AeroColors.sunnyYellow,
    LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [AeroColors.sunnyYellow, Color(0xFFFF9800)]),
    'Translucent, floating spheres simulating bokeh and adding a sense of tactile depth and playfulness.'
  ),
];
