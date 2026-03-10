import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/weather_data.dart';
import '../services/weather_service.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/weather_icon_widget.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  WeatherData? _weatherData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final data = await _weatherService.getWeatherData();
      setState(() {
        _weatherData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: AeroColors.waterBlue));
    }

    if (_weatherData == null) {
      return const Center(child: Text("Error loading 7-day forecast", style: TextStyle(color: AeroColors.darkText)));
    }

    final daily = _weatherData!.daily;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 20),
            sliver: SliverToBoxAdapter(
              child: const Text(
                '7-Day Forecast',
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
                    child: _buildDailyCard(daily[index], index),
                  );
                },
                childCount: daily.length,
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 120)),
        ],
      ),
    );
  }

  Widget _buildDailyCard(DailyForecast item, int index) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    String dayName = index == 0 ? 'Today' : days[item.time.weekday - 1];

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
          WeatherConditionIcon(code: item.code, size: 40, animate: false),
          Row(
            children: [
              Text('${item.maxTemp.round()}°', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AeroColors.darkText)),
              const SizedBox(width: 8),
              Text('${item.minTemp.round()}°', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: AeroColors.mutedText)),
            ],
          )
        ],
      ),
    ).animate().slideY(begin: 0.3, delay: (50 * index).ms);
  }
}
