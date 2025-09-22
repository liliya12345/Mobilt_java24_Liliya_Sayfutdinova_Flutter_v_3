import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather.dart';

Future<Weather> getWeatherData(String currentCity) async {
  try {
    final Dio dio = Dio();
    final API_KEY = 'fc13fddde004e0dc9789103fb77e5e9d';

    final response = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather?q=$currentCity&appid=$API_KEY',
    );

    final data = response.data as Map<String, dynamic>;
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        data['dt'] * 1000);

    final weather = Weather(
        temperature: (data['main']['temp'] - 273.0).round(),
        main: data['weather'][0]['main'],
        maxTemp: (data['main']['temp_max'] - 273.0).round(),
        minTemp: (data['main']['temp_min'] - 273.0).round(),
        wind: data['wind']['speed'].toDouble(),
        sunrise: data['sys']['sunrise'],
        sunset: data['sys']['sunset'],
        dt: data['dt'],
        dateTime: dateTime,
        name: data['name']
    );

    print('Weather data for: ${data['name']}');
    return weather;
  } catch (e) {
    print('Error fetching weather data: $e');
    rethrow;
  }
}

Future<String> getCityFromIP() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String _apiUrl = 'https://ipinfo.io/json';
  final String _defaultCity = 'Stockholm';

  try {
    final dio = Dio();
    final response = await dio.get(_apiUrl);

    if (response.statusCode != 200) {
      return _defaultCity;
    }

    final String city = response.data['city']?.toString() ?? '';

    // Сохраняем город только если он не пустой
    if (city.isNotEmpty) {
      await prefs.setString('city', city);
    }

    return city.isNotEmpty ? city : _defaultCity;
  } catch (e) {
    print('Error getting city from IP: $e');
    return _defaultCity;
  }
}