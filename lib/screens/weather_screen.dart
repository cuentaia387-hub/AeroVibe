import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/weather_data.dart';
import '../widgets/glass_card.dart';
import '../widgets/bubble_painter.dart';
import '../widgets/weather_icon_widget.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with SingleTickerProviderStateMixin {
  final weather = WeatherData.sample;
  late AnimationController _fadeController;

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
        count: 10,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
              const SizedBox(height: 24),
              _buildHeroWeatherCard(),
              const SizedBox(height: 20),
              _buildWeeklyForecast(),
              const SizedBox(height: 20),
              _buildDetailCards(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AeroColors.skyGradient.createShader(bounds),
          child: const Text(
            'Weather',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
        const Text(
          'Live conditions for Eden Valley',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 14,
            color: AeroColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroWeatherCard() {
    return GlassCard(
      borderRadius: 28,
      padding: const EdgeInsets.all(28),
      child: Column(
        children: [
          WeatherConditionIcon(
            condition: weather.conditionType,
            size: 80,
            animated: true,
          ),
          const SizedBox(height: 16),
          ShaderMask(
            shaderCallback: (bounds) =>
                AeroColors.skyGradient.createShader(bounds),
            child: Text(
              '${weather.temperature.toInt()}°C',
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 64,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            weather.condition,
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AeroColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          // Divider
          Container(
            height: 1,
            color: Colors.white.withOpacity(0.15),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMiniStat('💧', 'Humidity', '${weather.humidity}%'),
              _buildMiniStat('💨', 'Wind', '${weather.windSpeed.toInt()} km/h'),
              _buildMiniStat('☀️', 'UV', '${weather.uvIndex}'),
              _buildMiniStat('🌫️', 'AQI', '${weather.airQuality.toInt()}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String emoji, String label, String value) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AeroColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 11,
            color: AeroColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyForecast() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '7-Day Forecast',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AeroColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        GlassCard(
          padding: const EdgeInsets.all(16),
          borderRadius: 24,
          child: Column(
            children: weather.daily.asMap().entries.map((entry) {
              final i = entry.key;
              final d = entry.value;
              return Column(
                children: [
                  _buildDayRow(d),
                  if (i < weather.daily.length - 1)
                    Divider(
                        color: Colors.white.withOpacity(0.1),
                        height: 16),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDayRow(DailyForecast d) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 44,
            child: Text(
              d.day,
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AeroColors.textSecondary,
              ),
            ),
          ),
          WeatherConditionIcon(condition: d.condition, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              children: [
                Text(
                  '${d.rain}%',
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 12,
                    color: AeroColors.skyBlue,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: d.rain / 100,
                      backgroundColor: Colors.white.withOpacity(0.1),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          AeroColors.skyBlue),
                      minHeight: 4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(
            '${d.low.toInt()}°',
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 14,
              color: AeroColors.textMuted,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${d.high.toInt()}°',
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AeroColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Details',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AeroColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: GlassCard(
                padding: const EdgeInsets.all(20),
                borderRadius: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('🌅', style: TextStyle(fontSize: 28)),
                    const SizedBox(height: 8),
                    const Text(
                      'Sunrise',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        color: AeroColors.textMuted,
                      ),
                    ),
                    const Text(
                      '6:42 AM',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AeroColors.sunGold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GlassCard(
                padding: const EdgeInsets.all(20),
                borderRadius: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('🌇', style: TextStyle(fontSize: 28)),
                    const SizedBox(height: 8),
                    const Text(
                      'Sunset',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 12,
                        color: AeroColors.textMuted,
                      ),
                    ),
                    const Text(
                      '7:18 PM',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AeroColors.sunsetOrange,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GlassCard(
          padding: const EdgeInsets.all(20),
          borderRadius: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text('🌡️', style: TextStyle(fontSize: 22)),
                  SizedBox(width: 10),
                  Text(
                    'Temperature Trend',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AeroColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildTempGraph(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTempGraph() {
    final temps = weather.hourly.map((h) => h.temp).toList();
    final minTemp = temps.reduce((a, b) => a < b ? a : b);
    final maxTemp = temps.reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: 80,
      child: CustomPaint(
        painter: _TempCurvePainter(
          temps: temps,
          min: minTemp,
          max: maxTemp,
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _TempCurvePainter extends CustomPainter {
  final List<double> temps;
  final double min;
  final double max;

  _TempCurvePainter({required this.temps, required this.min, required this.max});

  @override
  void paint(Canvas canvas, Size size) {
    if (temps.isEmpty) return;

    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [AeroColors.skyBlue, AeroColors.primaryAqua],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AeroColors.primaryAqua.withOpacity(0.3),
          AeroColors.primaryAqua.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final range = (max - min).clamp(1.0, double.infinity);
    final points = <Offset>[];
    for (int i = 0; i < temps.length; i++) {
      final x = (i / (temps.length - 1)) * size.width;
      final normalized = (temps[i] - min) / range;
      final y = size.height - (normalized * (size.height - 16)) - 8;
      points.add(Offset(x, y));
    }

    // Smooth curve with cubic bezier
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 0; i < points.length - 1; i++) {
      final cp1 =
          Offset((points[i].dx + points[i + 1].dx) / 2, points[i].dy);
      final cp2 =
          Offset((points[i].dx + points[i + 1].dx) / 2, points[i + 1].dy);
      path.cubicTo(
          cp1.dx, cp1.dy, cp2.dx, cp2.dy, points[i + 1].dx, points[i + 1].dy);
    }

    // Fill area
    final fillPath = Path.from(path)
      ..lineTo(points.last.dx, size.height)
      ..lineTo(points.first.dx, size.height)
      ..close();
    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    // Draw dots at each point
    final dotPaint = Paint()
      ..color = AeroColors.primaryAqua
      ..style = PaintingStyle.fill;
    final glowPaint = Paint()
      ..color = AeroColors.primaryAqua.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    for (final pt in points) {
      canvas.drawCircle(pt, 5, glowPaint);
      canvas.drawCircle(pt, 3, dotPaint);
      canvas.drawCircle(
          pt,
          2,
          Paint()
            ..color = Colors.white
            ..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(_TempCurvePainter oldDelegate) => false;
}
