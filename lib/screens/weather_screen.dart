import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 20),
            sliver: SliverToBoxAdapter(
              child: const Text(
                'Pronóstico (Demo)',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: AeroColors.darkText,
                ),
              ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.1),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildDailyCard(index),
                  );
                },
                childCount: 7,
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 120)),
        ],
      ),
    );
  }

  Widget _buildDailyCard(int index) {
    final days = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
    final dayName = index == 0 ? 'Hoy' : days[(DateTime.now().weekday + index - 1) % 7];
    
    // Fake data for the aesthetic
    final maxTemp = 25 - (index % 3);
    final minTemp = 15 - (index % 2);
    final icon = index % 2 == 0 ? Icons.wb_sunny_rounded : Icons.cloud_rounded;
    final iconColor = index % 2 == 0 ? AeroColors.sunnyYellow : AeroColors.waterBlue;

    return GlassCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 60,
            child: Text(
              dayName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AeroColors.darkText),
            ),
          ),
          Icon(icon, size: 40, color: iconColor),
          Row(
            children: [
              Text('$maxTemp°', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AeroColors.darkText)),
              const SizedBox(width: 8),
              Text('$minTemp°', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: AeroColors.mutedText)),
            ],
          )
        ],
      ),
    ).animate().slideY(begin: 0.3, delay: (50 * index).ms);
  }
}
