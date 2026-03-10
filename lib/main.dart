import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/weather_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/settings_screen.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/bubble_painter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  runApp(const AeroVibeApp());
}

class AeroVibeApp extends StatelessWidget {
  const AeroVibeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AeroVibe',
      debugShowCheckedModeBanner: false,
      theme: AeroTheme.theme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const MainScaffold(),
      },
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    WeatherScreen(),
    ExploreScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AeroColors.deepOcean,
      body: Stack(
        children: [
          // Background gradient — persistent across all screens
          Container(
            decoration: const BoxDecoration(
              gradient: AeroColors.deepAuroraGradient,
            ),
          ),
          // Decorative aurora orbs
          const _AuroraOrbs(),
          // Screen content
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: KeyedSubtree(
              key: ValueKey(_currentIndex),
              child: _screens[_currentIndex],
            ),
          ),
          // Bottom navigation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AeroBottomNavBar(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuroraOrbs extends StatefulWidget {
  const _AuroraOrbs();

  @override
  State<_AuroraOrbs> createState() => _AuroraOrbsState();
}

class _AuroraOrbsState extends State<_AuroraOrbs>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, _) {
        return Stack(
          children: [
            // Top-left aurora orb (aqua)
            Positioned(
              top: -80 + _anim.value * 20,
              left: -60,
              child: _Orb(
                size: 280,
                color: AeroColors.primaryAqua.withOpacity(0.12),
              ),
            ),
            // Top-right orb (sky blue)
            Positioned(
              top: 60 - _anim.value * 15,
              right: -80,
              child: _Orb(
                size: 220,
                color: AeroColors.skyBlue.withOpacity(0.10),
              ),
            ),
            // Middle-left orb (nature green)
            Positioned(
              top: MediaQuery.of(context).size.height * 0.35 + _anim.value * 25,
              left: -50,
              child: _Orb(
                size: 180,
                color: AeroColors.natureGreen.withOpacity(0.07),
              ),
            ),
            // Bottom-right orb (purple aurora)
            Positioned(
              bottom: 80 - _anim.value * 20,
              right: -60,
              child: _Orb(
                size: 200,
                color: AeroColors.auroraViolet.withOpacity(0.08),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Orb extends StatelessWidget {
  final double size;
  final Color color;
  const _Orb({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
