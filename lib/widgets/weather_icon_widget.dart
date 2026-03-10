import 'package:flutter/material.dart';
import '../models/weather_data.dart';
import '../theme/app_theme.dart';

class WeatherConditionIcon extends StatelessWidget {
  final WeatherCondition condition;
  final double size;
  final bool animated;

  const WeatherConditionIcon({
    super.key,
    required this.condition,
    this.size = 60,
    this.animated = false,
  });

  String get emoji {
    switch (condition) {
      case WeatherCondition.sunny:
        return '☀️';
      case WeatherCondition.partlyCloudy:
        return '⛅';
      case WeatherCondition.cloudy:
        return '☁️';
      case WeatherCondition.rainy:
        return '🌧️';
      case WeatherCondition.stormy:
        return '⛈️';
      case WeatherCondition.snowy:
        return '❄️';
      case WeatherCondition.windy:
        return '💨';
      case WeatherCondition.night:
        return '🌙';
    }
  }

  Color get glowColor {
    switch (condition) {
      case WeatherCondition.sunny:
        return AeroColors.sunGold;
      case WeatherCondition.partlyCloudy:
        return AeroColors.skyBlue;
      case WeatherCondition.cloudy:
        return Colors.grey.shade400;
      case WeatherCondition.rainy:
        return AeroColors.deepSkyBlue;
      case WeatherCondition.stormy:
        return AeroColors.auroraViolet;
      case WeatherCondition.snowy:
        return AeroColors.mintGreen;
      case WeatherCondition.windy:
        return AeroColors.primaryAqua;
      case WeatherCondition.night:
        return AeroColors.auroraViolet;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size * 1.4,
      height: size * 1.4,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(0.4),
            blurRadius: size * 0.5,
            spreadRadius: size * 0.1,
          ),
        ],
      ),
      child: animated
          ? _AnimatedIcon(emoji: emoji, size: size)
          : Center(
              child: Text(emoji, style: TextStyle(fontSize: size * 0.75)),
            ),
    );
  }
}

class _AnimatedIcon extends StatefulWidget {
  final String emoji;
  final double size;
  const _AnimatedIcon({required this.emoji, required this.size});

  @override
  State<_AnimatedIcon> createState() => _AnimatedIconState();
}

class _AnimatedIconState extends State<_AnimatedIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _scale = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Center(
        child: Text(widget.emoji, style: TextStyle(fontSize: widget.size * 0.75)),
      ),
    );
  }
}

class WeatherStatCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final String emoji;
  final Color? accentColor;

  const WeatherStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    required this.emoji,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 22)),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  color: accentColor ?? AeroColors.primaryAqua,
                ),
              ),
              TextSpan(
                text: unit,
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AeroColors.textMuted,
                ),
              ),
            ],
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 11,
            color: AeroColors.textMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
