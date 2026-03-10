import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_data.dart';

class WeatherService {
  static const String _weatherUrl = 'https://api.open-meteo.com/v1/forecast';
  static const String _ipApiUrl = 'https://ipwho.is/'; // Free HTTPS IP location API

  // Helper to get user location via IP to bypass Android/Geolocator Gradle bugs completely!
  Future<Map<String, double>?> _determinePosition() async {
    try {
      final response = await http.get(Uri.parse(_ipApiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return {
            'latitude': (data['latitude'] as num).toDouble(),
            'longitude': (data['longitude'] as num).toDouble(),
          };
        }
      }
    } catch (e) {
      // If IP location fails, return null to fallback to default
    }
    return null;
  }

  Future<WeatherData> getWeatherData() async {
    double lat = 51.5085; // Default: London
    double lon = -0.1257;

    try {
      final position = await _determinePosition();
      if (position != null) {
        lat = position['latitude']!;
        lon = position['longitude']!;
      }
    } catch (e) {
      // Ignore location errors and just use defaults
    }

    final url = Uri.parse(
      '$_weatherUrl?latitude=$lat&longitude=$lon&current=temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,weather_code,wind_speed_10m&hourly=temperature_2m,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=auto'
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WeatherData.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
