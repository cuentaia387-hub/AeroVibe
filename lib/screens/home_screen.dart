import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/weather_data.dart';
import '../widgets/glass_card.dart';
import '../widgets/bubble_painter.dart';
import '../widgets/glossy_button.dart';
import '../widgets/weather_icon_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final weather = WeatherData.sample;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: AnimatedBubbles(
        count: 15,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(),
              const SizedBox(height: 24),

              // Main weather card
              _buildMainWeatherCard(),
              const SizedBox(height: 20),

              // Stats row
              _buildStatsRow(),
              const SizedBox(height: 20),

              // Hourly forecast 
              _buildHourlyForecast(),
              const SizedBox(height: 20),

              // Nature highlights
              _buildNatureHighlights(),
              const SizedBox(height: 20),

              // Action buttons
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Good Morning ✨',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AeroColors.textMuted,
              ),
            ),
            const SizedBox(height: 2),
            ShaderMask(
              shaderCallback: (bounds) =>
                  AeroColors.skyGradient.createShader(bounds),
              child: const Text(
                'Eden Valley',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        GlossyIconButton(
          icon: const Text('🔔', style: TextStyle(fontSize: 20)),
          gradient: AeroColors.aquaGradient,
          size: 48,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildMainWeatherCard() {
    return GlassCard(
      borderRadius: 28,
      padding: const EdgeInsets.all(24),
      shadows: [
        BoxShadow(
          color: AeroColors.primaryAqua.withOpacity(0.2),
          blurRadius: 30,
          offset: const Offset(0, 10),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${weather.temperature.toInt()}°',
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 80,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 0.9,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    weather.condition,
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AeroColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Feels like ${weather.feelsLike.toInt()}°',
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 13,
                      color: AeroColors.textMuted,
                    ),
                  ),
                ],
              ),
              WeatherConditionIcon(
                condition: weather.conditionType,
                size: 70,
                animated: true,
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Progress bar style "weather quality bar"
          _buildWeatherQualityBar(),
        ],
      ),
    );
  }

  Widget _buildWeatherQualityBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Air Quality Index',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 12,
            color: AeroColors.textMuted,
          ),
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: weather.airQuality / 100,
            backgroundColor: Colors.white.withOpacity(0.1),
            valueColor: const AlwaysStoppedAnimation<Color>(AeroColors.natureGreen),
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'AQI ${weather.airQuality.toInt()} · Good',
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 11,
                color: AeroColors.natureGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'UV ${weather.uvIndex}',
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 11,
                color: AeroColors.textMuted,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: GlassCard(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            borderRadius: 20,
            child: WeatherStatCard(
              label: 'Humidity',
              value: '${weather.humidity}',
              unit: '%',
              emoji: '💧',
              accentColor: AeroColors.skyBlue,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GlassCard(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            borderRadius: 20,
            child: WeatherStatCard(
              label: 'Wind',
              value: '${weather.windSpeed.toInt()}',
              unit: ' km/h',
              emoji: '💨',
              accentColor: AeroColors.primaryAqua,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GlassCard(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            borderRadius: 20,
            child: WeatherStatCard(
              label: 'UV Index',
              value: '${weather.uvIndex}',
              unit: '',
              emoji: '☀️',
              accentColor: AeroColors.sunGold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHourlyForecast() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hourly Forecast',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AeroColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: weather.hourly.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final h = weather.hourly[index];
              final isNow = index == 0;
              return GlassCard(
                width: 70,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                borderRadius: 18,
                color: isNow ? AeroColors.primaryAqua : null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      h.time,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isNow ? Colors.white : AeroColors.textMuted,
                      ),
                    ),
                    WeatherConditionIcon(
                        condition: h.condition, size: 24),
                    Text(
                      '${h.temp.toInt()}°',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: isNow ? Colors.white : AeroColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNatureHighlights() {
    final items = NatureItem.samples.take(2).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Nature Highlights',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AeroColors.textPrimary,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'See all →',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AeroColors.primaryAqua,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                padding: const EdgeInsets.all(16),
                borderRadius: 20,
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [
                            item.primaryColor,
                            item.primaryColor.withOpacity(0.6),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          item.emoji,
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AeroColors.textPrimary,
                            ),
                          ),
                          Text(
                            item.category,
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 12,
                              color: item.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 12,
                              color: AeroColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      children: [
                        const Text('⭐', style: TextStyle(fontSize: 14)),
                        Text(
                          '${item.rating}',
                          style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AeroColors.sunGold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: GlossyButton(
            label: 'Explore Nature',
            icon: const Text('🌿', style: TextStyle(fontSize: 16)),
            gradient: AeroColors.greenGradient,
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GlossyButton(
            label: 'Full Forecast',
            icon: const Text('🌤️', style: TextStyle(fontSize: 16)),
            gradient: AeroColors.aquaGradient,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
