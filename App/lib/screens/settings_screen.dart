import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _autoLocation = false;
  bool _24HourTime = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Handled by Main
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 20),
            sliver: SliverToBoxAdapter(
              child: const Text(
                'Ajustes',
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
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildProfileCard(),
                  const SizedBox(height: 24),
                  _buildGeneralSettings(),
                  const SizedBox(height: 120), // Bottom padding for nav bar
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return GlassCard(
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AeroColors.brightSkyGradient,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Usuario Aero', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AeroColors.darkText)),
              Text('Optimista y Visionario', style: TextStyle(color: AeroColors.mutedText)),
            ],
          )
        ],
      ),
    ).animate().slideY(begin: 0.2);
  }

  Widget _buildGeneralSettings() {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
            child: Text('PREFERENCIAS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AeroColors.waterBlue, letterSpacing: 1.2)),
          ),
          _buildToggleTile(
            title: 'Notificaciones Push',
            icon: Icons.notifications_active,
            value: _notifications,
            onChanged: (v) => setState(() => _notifications = v),
          ),
          const Divider(color: AeroColors.glassWhite),
          _buildToggleTile(
            title: 'Ubicación Automática',
            icon: Icons.location_on,
            value: _autoLocation,
            onChanged: (v) => setState(() => _autoLocation = v),
          ),
          const Divider(color: AeroColors.glassWhite),
          _buildToggleTile(
            title: 'Formato 24 Horas',
            icon: Icons.access_time,
            value: _24HourTime,
            onChanged: (v) => setState(() => _24HourTime = v),
          ),
        ],
      ),
    ).animate().slideY(begin: 0.2, delay: 100.ms);
  }



  Widget _buildToggleTile({required String title, required IconData icon, required bool value, required Function(bool) onChanged}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.5), shape: BoxShape.circle),
        child: Icon(icon, color: AeroColors.darkText, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: AeroColors.darkText)),
      trailing: _AeroSwitch(value: value, onChanged: onChanged),
    );
  }
}

// Custom Frutiger Aero Glossy Switch
class _AeroSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _AeroSwitch({Key? key, required this.value, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onChanged(!value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: 50,
          height: 28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white, width: 2),
            gradient: LinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter,
              colors: value 
                  ? [AeroColors.natureGreen, AeroColors.grassGreen]
                  : [Colors.grey.shade300, Colors.grey.shade400],
            ),
            boxShadow: [
              BoxShadow(
                color: (value ? AeroColors.natureGreen : Colors.black).withOpacity(0.2),
                blurRadius: 5, spreadRadius: 1, offset: const Offset(0, 2)
              )
            ]
          ),
          child: Stack(
            children: [
              // Inner Gloss highlight
              Positioned(
                top: 0, left: 4, right: 4, height: 10,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white.withOpacity(0.4)
                  ),
                ),
              ),
              // The thumb/knob
              AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutBack,
                alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.all(2),
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
