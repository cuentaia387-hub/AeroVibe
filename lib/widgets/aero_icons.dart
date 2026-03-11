import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AeroIconBase extends StatelessWidget {
  final Widget child;
  final double size;
  final List<Color> colors;
  final bool isCircle;

  const AeroIconBase({
    Key? key,
    required this.child,
    this.size = 28,
    this.colors = const [AeroColors.skyBlue, AeroColors.waterBlue],
    this.isCircle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : BorderRadius.circular(size * 0.2),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: colors,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.first.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glossy Top Highlight
          Positioned(
            top: size * 0.05,
            left: size * 0.15,
            right: size * 0.15,
            height: size * 0.35,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.8),
                    Colors.white.withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ),
          // The actual icon
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: size * 0.65,
              height: size * 0.65,
              child: FittedBox(
                fit: BoxFit.contain,
                child: child,
              ),
            ),
          ),
          // Inner Bubbles Effect
          Positioned(
            bottom: size * 0.15,
            right: size * 0.2,
            child: Container(
              width: size * 0.12,
              height: size * 0.12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AeroHomeIcon extends StatelessWidget {
  final double size;
  const AeroHomeIcon({Key? key, this.size = 28}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AeroIconBase(
      size: size,
      colors: const [AeroColors.waterBlue, AeroColors.skyBlue],
      child: const Icon(Icons.home_rounded, color: Colors.white, size: 40),
    );
  }
}

class AeroNotesIcon extends StatelessWidget {
  final double size;
  const AeroNotesIcon({Key? key, this.size = 28}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AeroIconBase(
      size: size,
      colors: const [AeroColors.natureGreen, Colors.tealAccent],
      child: const Icon(Icons.description_rounded, color: Colors.white, size: 40),
    );
  }
}

class AeroCenterIcon extends StatelessWidget {
  final double size;
  const AeroCenterIcon({Key? key, this.size = 28}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AeroIconBase(
      size: size,
      colors: const [Colors.purpleAccent, Colors.blueAccent],
      child: const Icon(Icons.grid_view_rounded, color: Colors.white, size: 40),
    );
  }
}

class AeroSettingsIcon extends StatelessWidget {
  final double size;
  const AeroSettingsIcon({Key? key, this.size = 28}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AeroIconBase(
      size: size,
      colors: const [Colors.grey, Colors.blueGrey],
      child: const Icon(Icons.settings_rounded, color: Colors.white, size: 40),
    );
  }
}

class AeroClockIcon extends StatelessWidget {
  final double size;
  const AeroClockIcon({Key? key, this.size = 28}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AeroIconBase(
      size: size,
      colors: const [AeroColors.waterBlue, AeroColors.skyBlue],
      child: const Icon(Icons.access_time_filled_rounded, color: Colors.white, size: 40),
    );
  }
}

class AeroCPUIcon extends StatelessWidget {
  final double size;
  const AeroCPUIcon({Key? key, this.size = 28}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AeroIconBase(
      size: size,
      colors: const [AeroColors.waterBlue, Colors.indigoAccent],
      isCircle: false,
      child: const Icon(Icons.memory_rounded, color: Colors.white, size: 40),
    );
  }
}

class AeroRAMIcon extends StatelessWidget {
  final double size;
  const AeroRAMIcon({Key? key, this.size = 28}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AeroIconBase(
      size: size,
      colors: const [AeroColors.sunnyYellow, Colors.orangeAccent],
      isCircle: false,
      child: const Icon(Icons.speed_rounded, color: Colors.white, size: 40),
    );
  }
}

class AeroBatteryIcon extends StatelessWidget {
  final double size;
  const AeroBatteryIcon({Key? key, this.size = 28}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AeroIconBase(
      size: size,
      colors: const [AeroColors.natureGreen, Colors.lightGreenAccent],
      isCircle: false,
      child: const Icon(Icons.battery_charging_full_rounded, color: Colors.white, size: 40),
    );
  }
}

class AeroStorageIcon extends StatelessWidget {
  final double size;
  const AeroStorageIcon({Key? key, this.size = 28}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AeroIconBase(
      size: size,
      colors: const [Colors.blueGrey, Colors.blue],
      isCircle: false,
      child: const Icon(Icons.storage_rounded, color: Colors.white, size: 40),
    );
  }
}

class AeroNetworkIcon extends StatelessWidget {
  final double size;
  const AeroNetworkIcon({Key? key, this.size = 28}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AeroIconBase(
      size: size,
      colors: const [AeroColors.skyBlue, Colors.blueAccent],
      isCircle: true,
      child: const Icon(Icons.wifi_rounded, color: Colors.white, size: 40),
    );
  }
}
