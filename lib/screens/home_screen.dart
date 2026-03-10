import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/weather_data.dart';
import '../services/weather_service.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/weather_icon_widget.dart';
import '../widgets/glossy_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService _weatherService = WeatherService();
  WeatherData? _weatherData;
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });
    try {
      final data = await _weatherService.getWeatherData();
      setState(() {
        _weatherData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: AeroColors.waterBlue));
    }

    if (_error.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 60),
            const SizedBox(height: 16),
            Text('Error loading weather data', style: TextStyle(color: AeroColors.darkText, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            GlossyButton(
              text: 'Retry',
              icon: Icons.refresh,
              onPressed: _fetchWeather,
              width: 150,
            ),
          ],
        ),
      );
    }

    final weather = _weatherData!;

    // SingleChildScrollView allows scrolling through everything
    return Scaffold(
      backgroundColor: Colors.transparent, // Background handled by Main widget
      body: RefreshIndicator(
        onRefresh: _fetchWeather,
        color: AeroColors.waterBlue,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(), // Important for RefreshIndicator
          padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 30),
              _buildMainWeatherCard(weather),
              const SizedBox(height: 30),
              _buildSectionTitle('Hourly Forecast'),
              const SizedBox(height: 16),
              _buildHourlyList(weather.hourly),
              const SizedBox(height: 30),
              _buildSectionTitle('Interaction Demo'),
              const SizedBox(height: 16),
              _buildInteractionArea(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Good morning 👋',
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
            'Current Location', // API uses coords, so we generalize
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Colors.white, // Required for shader mask
            ),
          ),
        ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1),
      ],
    );
  }

  Widget _buildMainWeatherCard(WeatherData weather) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${weather.currentTemp.round()}°',
                    style: const TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.w200, // Thin modern font
                      color: AeroColors.waterBlue,
                      letterSpacing: -3,
                    ),
                  ),
                  Text(
                    weather.conditionString,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AeroColors.darkText,
                    ),
                  ),
                ],
              ),
              WeatherConditionIcon(code: weather.weatherCode, size: 80),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(color: AeroColors.glassWhite),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WeatherStatCard(
                icon: Icons.water_drop,
                label: 'HUMIDITY',
                value: '${weather.humidity}%',
              ),
              WeatherStatCard(
                icon: Icons.air,
                label: 'WIND',
                value: '${weather.windSpeed.round()} km/h',
                color: AeroColors.natureGreen,
              ),
            ],
          ),
        ],
      ),
    ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack);
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

  Widget _buildHourlyList(List<HourlyForecast> hourly) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hourly.length, // Show next 24 hours
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = hourly[index];
          final timeStr = '${item.time.hour.toString().padLeft(2, '0')}:00';
          
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GlassCard(
              width: 80,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(timeStr, style: const TextStyle(fontWeight: FontWeight.bold, color: AeroColors.mutedText)),
                  WeatherConditionIcon(code: item.code, size: 36, animate: false),
                  Text('${item.temp.round()}°', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AeroColors.darkText)),
                ],
              ),
            ).animate().slideX(begin: 0.5, delay: (100 * index).ms),
          );
        },
      ),
    );
  }

  Widget _buildInteractionArea() {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'This button demonstrates interactive state in the Frutiger Aero aesthetic.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AeroColors.mutedText),
          ),
          const SizedBox(height: 16),
          GlossyButton(
            text: 'Press Me!',
            icon: Icons.touch_app,
            width: double.infinity,
            baseColor: AeroColors.natureGreen,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AeroColors.waterBlue,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  content: const Text('Interaction recorded! Fully functional glossy button.', 
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              );
            },
          ),
        ],
      ),
    ).animate().fadeIn(delay: 800.ms);
  }
}
