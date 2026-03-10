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
                'Aero Center',
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
                  if (index == 0) return _buildMainStatusCard();
                  if (index == 1) return const SizedBox(height: 16);
                  if (index == 2) return _buildStorageCard();
                  if (index == 3) return const SizedBox(height: 16);
                  if (index == 4) return _buildNetworkCard();
                  return null;
                },
                childCount: 5,
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 120)),
        ],
      ),
    );
  }

  Widget _buildMainStatusCard() {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Estado del Sistema',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AeroColors.darkText),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AeroColors.natureGreen.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AeroColors.natureGreen),
                ),
                child: const Text('Óptimo', style: TextStyle(color: AeroColors.natureGreen, fontWeight: FontWeight.bold, fontSize: 12)),
              )
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCircularProgress('CPU', 0.35, AeroColors.waterBlue, Icons.memory),
              _buildCircularProgress('RAM', 0.68, AeroColors.sunnyYellow, Icons.speed),
              _buildCircularProgress('Batería', 0.92, AeroColors.natureGreen, Icons.battery_charging_full),
            ],
          ),
        ],
      ),
    ).animate().slideY(begin: 0.2, duration: 400.ms);
  }

  Widget _buildCircularProgress(String label, double percent, Color color, IconData icon) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: CircularProgressIndicator(
                value: percent,
                strokeWidth: 8,
                backgroundColor: Colors.white.withOpacity(0.3),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            Icon(icon, color: AeroColors.darkText.withOpacity(0.8), size: 28),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          '${(percent * 100).toInt()}%',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AeroColors.darkText),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AeroColors.mutedText, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildStorageCard() {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.storage_rounded, color: AeroColors.waterBlue),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Almacenamiento Local', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AeroColors.darkText)),
                    Text('45.2 GB libres de 128 GB', style: TextStyle(color: AeroColors.mutedText, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.65,
              minHeight: 12,
              backgroundColor: Colors.white.withOpacity(0.5),
              valueColor: const AlwaysStoppedAnimation<Color>(AeroColors.waterBlue),
            ),
          ),
        ],
      ),
    ).animate().slideY(begin: 0.2, delay: 100.ms, duration: 400.ms);
  }

  Widget _buildNetworkCard() {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AeroColors.skyBlue, AeroColors.waterBlue]),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(color: AeroColors.waterBlue.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))],
            ),
            child: const Icon(Icons.wifi_rounded, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Red Aero-Net', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AeroColors.darkText)),
                SizedBox(height: 4),
                Text('Conectado • 5G Ultra Wideband', style: TextStyle(color: AeroColors.mutedText, fontSize: 13)),
              ],
            ),
          ),
          const Icon(Icons.check_circle_rounded, color: AeroColors.natureGreen),
        ],
      ),
    ).animate().slideY(begin: 0.2, delay: 200.ms, duration: 400.ms);
  }
}
