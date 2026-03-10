import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/bubble_painter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;

  // Settings state
  bool _notifications = true;
  bool _darkMode = true;
  bool _locationAccess = true;
  bool _animatedBg = true;
  bool _metricUnits = true;
  bool _autoRefresh = false;
  double _blurIntensity = 12.0;
  String _language = 'English';
  String _theme = 'Aurora Night';

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
      child: AnimatedBubbles(
        count: 6,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              ShaderMask(
                shaderCallback: (bounds) =>
                    AeroColors.skyGradient.createShader(bounds),
                child: const Text(
                  'Settings',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              const Text(
                'Personalize your AeroVibe experience',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 14,
                  color: AeroColors.textMuted,
                ),
              ),
              const SizedBox(height: 28),

              // Profile card
              _buildProfileCard(),
              const SizedBox(height: 20),

              // Appearance section
              _buildSectionHeader('🎨 Appearance'),
              const SizedBox(height: 10),
              GlassCard(
                padding: const EdgeInsets.symmetric(vertical: 4),
                borderRadius: 20,
                child: Column(
                  children: [
                    _buildToggleTile(
                      icon: '🌙',
                      label: 'Dark Mode',
                      subtitle: 'Deep ocean background',
                      value: _darkMode,
                      onChanged: (v) => setState(() => _darkMode = v),
                    ),
                    _buildDivider(),
                    _buildToggleTile(
                      icon: '🫧',
                      label: 'Animated Bubbles',
                      subtitle: 'Frutiger Aero bokeh effect',
                      value: _animatedBg,
                      onChanged: (v) => setState(() => _animatedBg = v),
                    ),
                    _buildDivider(),
                    _buildSliderTile(
                      icon: '❄️',
                      label: 'Glass Blur',
                      subtitle: 'Glassmorphism intensity',
                      value: _blurIntensity,
                      min: 4,
                      max: 25,
                      onChanged: (v) => setState(() => _blurIntensity = v),
                    ),
                    _buildDivider(),
                    _buildDropdownTile(
                      icon: '🌅',
                      label: 'Theme',
                      value: _theme,
                      options: const [
                        'Aurora Night',
                        'Ocean Breeze',
                        'Forest Glow',
                        'Sunset Haze'
                      ],
                      onChanged: (v) => setState(() => _theme = v!),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Notifications section
              _buildSectionHeader('🔔 Notifications'),
              const SizedBox(height: 10),
              GlassCard(
                padding: const EdgeInsets.symmetric(vertical: 4),
                borderRadius: 20,
                child: Column(
                  children: [
                    _buildToggleTile(
                      icon: '📳',
                      label: 'Push Notifications',
                      subtitle: 'Weather alerts & updates',
                      value: _notifications,
                      onChanged: (v) => setState(() => _notifications = v),
                    ),
                    _buildDivider(),
                    _buildToggleTile(
                      icon: '🔄',
                      label: 'Auto Refresh',
                      subtitle: 'Update every 30 min in background',
                      value: _autoRefresh,
                      onChanged: (v) => setState(() => _autoRefresh = v),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Data & Privacy section
              _buildSectionHeader('🔒 Data & Privacy'),
              const SizedBox(height: 10),
              GlassCard(
                padding: const EdgeInsets.symmetric(vertical: 4),
                borderRadius: 20,
                child: Column(
                  children: [
                    _buildToggleTile(
                      icon: '📍',
                      label: 'Location Access',
                      subtitle: 'Auto-detect your location',
                      value: _locationAccess,
                      onChanged: (v) => setState(() => _locationAccess = v),
                    ),
                    _buildDivider(),
                    _buildToggleTile(
                      icon: '📏',
                      label: 'Metric Units',
                      subtitle: '°C, km/h, mm',
                      value: _metricUnits,
                      onChanged: (v) => setState(() => _metricUnits = v),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Language
              _buildSectionHeader('🌐 Region'),
              const SizedBox(height: 10),
              GlassCard(
                padding: const EdgeInsets.symmetric(vertical: 4),
                borderRadius: 20,
                child: _buildDropdownTile(
                  icon: '🗣️',
                  label: 'Language',
                  value: _language,
                  options: const ['English', 'Español', 'Français', 'Deutsch', '日本語'],
                  onChanged: (v) => setState(() => _language = v!),
                ),
              ),
              const SizedBox(height: 20),

              // About section
              _buildSectionHeader('ℹ️ About'),
              const SizedBox(height: 10),
              GlassCard(
                padding: const EdgeInsets.symmetric(vertical: 4),
                borderRadius: 20,
                child: Column(
                  children: [
                    _buildInfoTile(icon: '📱', label: 'Version', value: '1.0.0'),
                    _buildDivider(),
                    _buildInfoTile(
                        icon: '🎨',
                        label: 'Design',
                        value: 'Frutiger Aero'),
                    _buildDivider(),
                    _buildActionTile(
                        icon: '⭐',
                        label: 'Rate AeroVibe',
                        color: AeroColors.sunGold),
                    _buildDivider(),
                    _buildActionTile(
                        icon: '💬',
                        label: 'Send Feedback',
                        color: AeroColors.primaryAqua),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Aero branding
              Center(
                child: Column(
                  children: [
                    const Text('🌊', style: TextStyle(fontSize: 32)),
                    const SizedBox(height: 8),
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          AeroColors.skyGradient.createShader(bounds),
                      child: const Text(
                        'AeroVibe',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Inspired by Frutiger Aero\nNature · Glass · Harmony',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        color: AeroColors.textMuted,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return GlassCard(
      borderRadius: 24,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AeroColors.aquaGradient,
              boxShadow: [
                BoxShadow(
                  color: AeroColors.primaryAqua.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 28,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x50FFFFFF), Color(0x00FFFFFF)],
                      ),
                    ),
                  ),
                ),
                const Center(child: Text('🧑', style: TextStyle(fontSize: 32))),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nature Explorer',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AeroColors.textPrimary,
                  ),
                ),
                const Text(
                  'Eden Valley, Earth 🌍',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 13,
                    color: AeroColors.textMuted,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: AeroColors.aquaGradient,
                  ),
                  child: const Text(
                    '✨ Aero Member',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Nunito',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AeroColors.textSecondary,
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.white.withOpacity(0.08),
      height: 1,
      indent: 16,
      endIndent: 16,
    );
  }

  Widget _buildToggleTile({
    required String icon,
    required String label,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Text(icon, style: const TextStyle(fontSize: 22)),
      title: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AeroColors.textPrimary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 12,
          color: AeroColors.textMuted,
        ),
      ),
      trailing: _AeroSwitch(value: value, onChanged: onChanged),
    );
  }

  Widget _buildSliderTile({
    required String icon,
    required String label,
    required String subtitle,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AeroColors.textPrimary,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        color: AeroColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                value.toInt().toString(),
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AeroColors.primaryAqua,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: AeroColors.primaryAqua,
              inactiveTrackColor: Colors.white.withOpacity(0.1),
              thumbColor: AeroColors.primaryAqua,
              overlayColor: AeroColors.primaryAqua.withOpacity(0.2),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              trackHeight: 4,
            ),
            child: Slider(value: value, min: min, max: max, onChanged: onChanged),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownTile({
    required String icon,
    required String label,
    required String value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return ListTile(
      leading: Text(icon, style: const TextStyle(fontSize: 22)),
      title: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AeroColors.textPrimary,
        ),
      ),
      trailing: DropdownButton<String>(
        value: value,
        underline: const SizedBox(),
        dropdownColor: AeroColors.nightBlue,
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 13,
          color: AeroColors.primaryAqua,
          fontWeight: FontWeight.w600,
        ),
        items: options
            .map((o) => DropdownMenuItem(value: o, child: Text(o)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildInfoTile({
    required String icon,
    required String label,
    required String value,
  }) {
    return ListTile(
      leading: Text(icon, style: const TextStyle(fontSize: 22)),
      title: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AeroColors.textPrimary,
        ),
      ),
      trailing: Text(
        value,
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 13,
          color: AeroColors.textMuted,
        ),
      ),
    );
  }

  Widget _buildActionTile({
    required String icon,
    required String label,
    required Color color,
  }) {
    return ListTile(
      onTap: () {},
      leading: Text(icon, style: const TextStyle(fontSize: 22)),
      title: Text(
        label,
        style: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 14, color: color.withOpacity(0.7)),
    );
  }
}

class _AeroSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _AeroSwitch({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 52,
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: value ? AeroColors.aquaGradient : null,
          color: value ? null : Colors.white.withOpacity(0.15),
          boxShadow: value
              ? [
                  BoxShadow(
                    color: AeroColors.primaryAqua.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Stack(
          children: [
            // Gloss
            if (value)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 14,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(14)),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0x40FFFFFF), Color(0x00FFFFFF)],
                    ),
                  ),
                ),
              ),
            AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutBack,
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
