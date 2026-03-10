class WeatherData {
  final double currentTemp;
  final double apparentTemp;
  final int humidity;
  final double windSpeed;
  final int weatherCode;
  
  final List<HourlyForecast> hourly;
  final List<DailyForecast> daily;

  WeatherData({
    required this.currentTemp,
    required this.apparentTemp,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCode,
    required this.hourly,
    required this.daily,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final current = json['current'];
    final hourlyData = json['hourly'];
    final dailyData = json['daily'];

    // Parse Hourly
    List<HourlyForecast> hourlyList = [];
    if (hourlyData != null) {
      List<dynamic> times = hourlyData['time'];
      List<dynamic> temps = hourlyData['temperature_2m'];
      List<dynamic> codes = hourlyData['weather_code'];
      
      // Get the next 24 hours
      for (int i = 0; i < 24 && i < times.length; i++) {
        hourlyList.add(HourlyForecast(
          time: DateTime.parse(times[i]),
          temp: (temps[i] as num).toDouble(),
          code: codes[i] as int,
        ));
      }
    }

    // Parse Daily
    List<DailyForecast> dailyList = [];
    if (dailyData != null) {
       List<dynamic> times = dailyData['time'];
       List<dynamic> maxTemps = dailyData['temperature_2m_max'];
       List<dynamic> minTemps = dailyData['temperature_2m_min'];
       List<dynamic> codes = dailyData['weather_code'];

       for (int i = 0; i < 7 && i < times.length; i++) {
         dailyList.add(DailyForecast(
           time: DateTime.parse(times[i]),
           maxTemp: (maxTemps[i] as num).toDouble(),
           minTemp: (minTemps[i] as num).toDouble(),
           code: codes[i] as int,
         ));
       }
    }

    return WeatherData(
      currentTemp: (current['temperature_2m'] as num).toDouble(),
      apparentTemp: (current['apparent_temperature'] as num).toDouble(),
      humidity: current['relative_humidity_2m'] as int,
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
      weatherCode: current['weather_code'] as int,
      hourly: hourlyList,
      daily: dailyList,
    );
  }

  // WMO Weather interpretation codes
  String get conditionString {
    return getWeatherConditionString(weatherCode);
  }
}

class HourlyForecast {
  final DateTime time;
  final double temp;
  final int code;

  HourlyForecast({required this.time, required this.temp, required this.code});
}

class DailyForecast {
  final DateTime time;
  final double maxTemp;
  final double minTemp;
  final int code;

  DailyForecast({
    required this.time,
    required this.maxTemp,
    required this.minTemp,
    required this.code,
  });
}

String getWeatherConditionString(int code) {
  if (code == 0) return 'Clear sky';
  if (code == 1 || code == 2 || code == 3) return 'Partly cloudy';
  if (code >= 45 && code <= 48) return 'Foggy';
  if (code >= 51 && code <= 55) return 'Drizzle';
  if (code >= 61 && code <= 65) return 'Rain';
  if (code >= 71 && code <= 77) return 'Snow';
  if (code >= 80 && code <= 82) return 'Rain showers';
  if (code >= 95) return 'Thunderstorm';
  return 'Unknown';
}
