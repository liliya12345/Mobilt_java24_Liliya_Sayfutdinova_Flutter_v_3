// getWeatherData.dart
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Измените импорт
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../models/weather.dart';

Future<Weather> getWeatherData(String currentCity) async {
  try {
    final Dio dio = Dio();
    // final API_KEY = dotenv.env['API_KEY'];
    final API_KEY = 'fc13fddde004e0dc9789103fb77e5e9d';

    if (API_KEY == null || API_KEY.isEmpty) {
      throw Exception('API_KEY not found in .env file');
    }

    final response = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather?q=${currentCity}&appid=$API_KEY',
    );

    final data = response.data as Map<String, dynamic>;
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000);
    final weather = Weather(
        temperature: (data['main']['temp'] - 273.0).round(),
        main: data['weather'][0]['main'],
        maxTemp: (data['main']['temp_max'] - 273.0).round(),
        minTemp: (data['main']['temp_min'] - 273.0).round(),
        wind: data['wind']['speed'].toDouble(), // Правильное поле для скорости ветра
        sunrise: data['sys']['sunrise'], // Правильное поле для восхода
        sunset: data['sys']['sunset'], // Правильное поле для заката
        dt: data['dt'], // Время данных
        dateTime: dateTime, // Время данных
        name: data['name']
        );
        final city = response.data['name'];
        print(city);
    return weather;
  } catch (e) {
    print('Error fetching weather data: $e');
    rethrow;
  }
}

Future<String> getCurrentCity() async {
  try {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);

    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemarks[0].locality;
    return city ?? "Lund"; // Fallback на город по умолчанию
  } catch (e) {
    print('Error getting location: $e');
    return "Lund"; // Fallback на город по умолчанию
  }
}

