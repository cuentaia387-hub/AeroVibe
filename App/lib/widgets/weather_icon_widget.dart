import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/weather_data.dart';
import '../theme/app_theme.dart';

class WeatherConditionIcon extends StatelessWidget {
  final int code;
  final double size;
  final bool animate;

  const WeatherConditionIcon({
    Key? key,
    required this.code,
    this.size = 64,
    this.animate = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color iconColor;
    
    // Simplistic icon mapping based on WMO code
    if (code == 0) {
      iconData = Icons.wb_sunny_rounded;
      iconColor = AeroColors.sunnyYellow;
    } else if (code >= 1 && code <= 3) {
      iconData = Icons.cloud_queue_rounded; // partly cloudy
      iconColor = AeroColors.skyBlue;
    } else if (code >= 51 && code <= 65) {
      iconData = Icons.water_drop_rounded; // rain
      iconColor = AeroColors.waterBlue;
    } else if (code >= 71 && code <= 77) {
      iconData = Icons.ac_unit_rounded; // snow
      iconColor = Colors.lightBlueAccent;
    } else if (code >= 95) {
      iconData = Icons.flash_on_rounded; // thunderstorm
      iconColor = Colors.deepPurpleAccent;
    } else {
      iconData = Icons.cloud_rounded; // default cloudy/fog
      iconColor = Colors.grey.shade400;
    }

    Widget icon = Icon(
      iconData,
      size: size,
      color: iconColor,
      shadows: [
        Shadow(
          color: iconColor.withOpacity(0.5),
          blurRadius: 15,
          offset: const Offset(0, 4),
        )
      ],
    );

    if (animate) {
      return icon.animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 3000.ms, color: Colors.white.withOpacity(0.8))
        .scaleXY(begin: 0.95, end: 1.05, duration: 2000.ms, curve: Curves.easeInOutSine)
        .then()
        .scaleXY(begin: 1.05, end: 0.95, duration: 2000.ms, curve: Curves.easeInOutSine);
    }
    
    return icon;
  }
}

class WeatherStatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const WeatherStatCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    this.color = AeroColors.waterBlue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ]
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AeroColors.mutedText,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: AeroColors.darkText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
