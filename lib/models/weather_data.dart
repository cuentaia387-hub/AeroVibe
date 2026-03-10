import 'dart:math' as math;
import 'package:flutter/material.dart';

class WeatherData {
  final String city;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final String condition;
  final WeatherCondition conditionType;
  final double uvIndex;
  final double airQuality;
  final List<HourlyForecast> hourly;
  final List<DailyForecast> daily;

  const WeatherData({
    required this.city,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.condition,
    required this.conditionType,
    required this.uvIndex,
    required this.airQuality,
    required this.hourly,
    required this.daily,
  });

  static WeatherData get sample => WeatherData(
        city: 'Eden Valley',
        temperature: 22,
        feelsLike: 24,
        humidity: 68,
        windSpeed: 12,
        condition: 'Partly Cloudy',
        conditionType: WeatherCondition.partlyCloudy,
        uvIndex: 5.2,
        airQuality: 42,
        hourly: _sampleHourly,
        daily: _sampleDaily,
      );

  static final List<HourlyForecast> _sampleHourly = [
    HourlyForecast(time: 'Now', temp: 22, condition: WeatherCondition.partlyCloudy),
    HourlyForecast(time: '13:00', temp: 24, condition: WeatherCondition.sunny),
    HourlyForecast(time: '14:00', temp: 25, condition: WeatherCondition.sunny),
    HourlyForecast(time: '15:00', temp: 24, condition: WeatherCondition.cloudy),
    HourlyForecast(time: '16:00', temp: 21, condition: WeatherCondition.rainy),
    HourlyForecast(time: '17:00', temp: 19, condition: WeatherCondition.rainy),
    HourlyForecast(time: '18:00', temp: 18, condition: WeatherCondition.cloudy),
    HourlyForecast(time: '19:00', temp: 16, condition: WeatherCondition.partlyCloudy),
  ];

  static final List<DailyForecast> _sampleDaily = [
    DailyForecast(day: 'Today', high: 25, low: 15, condition: WeatherCondition.sunny, rain: 10),
    DailyForecast(day: 'Tue', high: 22, low: 14, condition: WeatherCondition.partlyCloudy, rain: 20),
    DailyForecast(day: 'Wed', high: 18, low: 12, condition: WeatherCondition.rainy, rain: 80),
    DailyForecast(day: 'Thu', high: 20, low: 13, condition: WeatherCondition.cloudy, rain: 40),
    DailyForecast(day: 'Fri', high: 24, low: 15, condition: WeatherCondition.sunny, rain: 5),
    DailyForecast(day: 'Sat', high: 26, low: 16, condition: WeatherCondition.sunny, rain: 5),
    DailyForecast(day: 'Sun', high: 23, low: 14, condition: WeatherCondition.partlyCloudy, rain: 15),
  ];
}

class HourlyForecast {
  final String time;
  final double temp;
  final WeatherCondition condition;

  const HourlyForecast({
    required this.time,
    required this.temp,
    required this.condition,
  });
}

class DailyForecast {
  final String day;
  final double high;
  final double low;
  final WeatherCondition condition;
  final int rain;

  const DailyForecast({
    required this.day,
    required this.high,
    required this.low,
    required this.condition,
    required this.rain,
  });
}

enum WeatherCondition {
  sunny,
  partlyCloudy,
  cloudy,
  rainy,
  stormy,
  snowy,
  windy,
  night,
}

class NatureItem {
  final String name;
  final String category;
  final String description;
  final String emoji;
  final List<String> tags;
  final double rating;
  final Color primaryColor;

  const NatureItem({
    required this.name,
    required this.category,
    required this.description,
    required this.emoji,
    required this.tags,
    required this.rating,
    required this.primaryColor,
  });

  static final List<NatureItem> samples = [
    NatureItem(
      name: 'Azure Morpho',
      category: 'Butterfly',
      description: 'The brilliant blue butterfly of the Amazon, known for its iridescent wings that shimmer like liquid mercury.',
      emoji: '🦋',
      tags: ['Rare', 'Amazon', 'Blue'],
      rating: 4.9,
      primaryColor: const Color(0xFF45B7D1),
    ),
    NatureItem(
      name: 'Crystal Falls',
      category: 'Waterfall',
      description: 'A pristine waterfall cascading over ancient rocks, creating a natural glass curtain of pure mountain water.',
      emoji: '💧',
      tags: ['Water', 'Mountain', 'Pure'],
      rating: 4.8,
      primaryColor: const Color(0xFF4ECDC4),
    ),
    NatureItem(
      name: 'Aurora Borealis',
      category: 'Phenomenon',
      description: 'Nature\'s own light show — dancing ribbons of emerald, violet and cyan across the arctic sky.',
      emoji: '🌌',
      tags: ['Arctic', 'Lights', 'Night'],
      rating: 5.0,
      primaryColor: const Color(0xFF8B5CF6),
    ),
    NatureItem(
      name: 'Jade Forest',
      category: 'Forest',
      description: 'Ancient bamboo groves where light filters through in emerald shafts, painting everything in soft green hues.',
      emoji: '🌿',
      tags: ['Forest', 'Bamboo', 'Green'],
      rating: 4.7,
      primaryColor: const Color(0xFF6BCB77),
    ),
    NatureItem(
      name: 'Pearl Jellyfish',
      category: 'Marine',
      description: 'Translucent creatures drifting in moonlit waters, their bioluminescent pulses lighting the dark ocean.',
      emoji: '🪼',
      tags: ['Ocean', 'Glow', 'Deep Sea'],
      rating: 4.8,
      primaryColor: const Color(0xFFC084FC),
    ),
    NatureItem(
      name: 'Golden Meadow',
      category: 'Meadow',
      description: 'Endless fields of sunflowers swaying gently, their golden faces tracking the sun across a cloudless blue sky.',
      emoji: '🌻',
      tags: ['Flowers', 'Sun', 'Open'],
      rating: 4.6,
      primaryColor: const Color(0xFFFFD93D),
    ),
    NatureItem(
      name: 'Twin Lakes',
      category: 'Lake',
      description: 'Mirror-perfect alpine lakes reflecting snow-capped peaks in crystal clarity — nature\'s own looking glass.',
      emoji: '🏔️',
      tags: ['Alpine', 'Mirror', 'Pure'],
      rating: 4.9,
      primaryColor: const Color(0xFF0EA5E9),
    ),
    NatureItem(
      name: 'Coral Garden',
      category: 'Marine',
      description: 'A vibrant underwater metropolis of neon corals housing thousands of tropical fish in a kaleidoscope of color.',
      emoji: '🐠',
      tags: ['Coral', 'Tropical', 'Color'],
      rating: 4.7,
      primaryColor: const Color(0xFFFF6B6B),
    ),
  ];
}

class AeroParticle {
  double x;
  double y;
  double radius;
  double opacity;
  double speed;
  double dx;
  double dy;
  Color color;

  AeroParticle({
    required this.x,
    required this.y,
    required this.radius,
    required this.opacity,
    required this.speed,
    required this.dx,
    required this.dy,
    required this.color,
  });

  static AeroParticle random(Size size) {
    final rng = math.Random();
    final colors = [
      const Color(0xFF4ECDC4),
      const Color(0xFF45B7D1),
      const Color(0xFF6BCB77),
      const Color(0xFFFFFFFF),
      const Color(0xFF8B5CF6),
      const Color(0xFFC084FC),
    ];
    return AeroParticle(
      x: rng.nextDouble() * size.width,
      y: rng.nextDouble() * size.height,
      radius: rng.nextDouble() * 30 + 5,
      opacity: rng.nextDouble() * 0.25 + 0.05,
      speed: rng.nextDouble() * 0.5 + 0.1,
      dx: (rng.nextDouble() - 0.5) * 0.5,
      dy: -(rng.nextDouble() * 0.5 + 0.1),
      color: colors[rng.nextInt(colors.length)],
    );
  }
}
