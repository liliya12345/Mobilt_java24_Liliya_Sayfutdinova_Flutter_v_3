// models/weather.dart
class Weather {
  final int temperature;
  final String main;
  final int maxTemp;
  final int minTemp;
  final String name;
  final double wind;
  final int sunset;
  final int sunrise;
  final int dt;
  final DateTime dateTime;

  Weather({
    required this.temperature,
    required this.main,
    required this.maxTemp,
    required this.minTemp,
    required this.name,
    required this.wind,
    required this.sunset,
    required this.sunrise,
    required this.dt,
    required this.dateTime,
  });
}
