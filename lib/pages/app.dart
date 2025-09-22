import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/theme.dart';
import 'package:weather_app/utils/getWeatherData.dart';
import '../models/weather.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/pages/secondPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'Weather App',
      home: const WeatherApp(),
    );
  }
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  Weather? weather;
  final TextEditingController _searchController = TextEditingController();
  String _currentCity = 'Stockholm';
  String animal = '';
  bool isSchool = true;
  bool _isLoading = true;

  Future<void> getData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedCity = prefs.getString('city');

      // Если нет сохраненного города, получаем из IP
      if (savedCity == null || savedCity.isEmpty) {
        savedCity = await getCityFromIP();
      }

      final data = await getWeatherData(savedCity);
      setState(() {
        weather = data;
        _currentCity = savedCity!;
        _isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      // Пробуем загрузить погоду для города по умолчанию
      try {
        final data = await getWeatherData(_currentCity);
        setState(() {
          weather = data;
          _isLoading = false;
        });
      } catch (e) {
        print('Second error: $e');
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _searchCity() async {
    final city = _searchController.text.trim();
    if (city.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      try {
        final data = await getWeatherData(city);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setString('city', city);

        setState(() {
          weather = data;
          _currentCity = city;
          _isLoading = false;
        });
      } catch (e) {
        print('Error searching city: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not find city: $city'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _isLoading = false;
        });
      }

      _searchController.clear();
    }
  }

  Color getColorOfDay(DateTime dateTime) {
    final day = DateFormat('EEEE').format(dateTime);
    switch(day) {
      case 'Saturday':
      case 'Sunday':
        isSchool = false;
        return const Color(0xFFEDA547);
      default:
        isSchool = true;
        return const Color(0xFFFFFFFE);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    animal = 'doggy';
    String animation = 'assets/snow.json';

    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        animal = 'cat';
        animation = 'assets/cloudy.json';
        break;
      case 'thunderstorm':
        animal = 'yay';
        animation = 'assets/thunder.json';
        break;
      case 'mist':
        animal = 'yay';
        animation = 'assets/snow.json';
        break;
      case 'smoke':
      case 'haze':
      case 'fog':
      case 'dust':
        animal = 'doggy';
        animation = 'assets/snow.json';
        break;
      case 'rain':
      case 'light rain':
      case 'light breeze':
      case 'drizzle':
      case 'shower rain':
        animal = 'cat';
        animation = 'assets/rain.json';
        break;
      case 'clear':
        animal = 'jello';
        animation = 'assets/sunny.json';
        break;
      default:
        animal = 'jello';
        animation = 'assets/sunny.json';
        break;
    }
    return animation;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.3),
        elevation: 0,
        title: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search city...',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: _searchCity,
            ),
          ),
          onSubmitted: (_) => _searchCity(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xF235B2E1),
              Color(0xFF5966A1),
              Color(0xFF633F9A),
              Color(0xFF9E368B),
              Color(0xFFE67BD5),
            ],
          ),
        ),
        child: _isLoading
            ? const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : ListView(
          children: [
            const SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('EEEE, MMMM d').format(weather!.dateTime),
                                style: TextStyle(
                                  fontSize: 22,
                                  color: getColorOfDay(weather!.dateTime),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                DateFormat('HH:mm').format(weather!.dateTime),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFFFFA000),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                isSchool ? "School day 🎒" : "Weekend 🎉",
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF01F301),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Lottie.asset(
                            getWeatherAnimation(weather?.main),
                            width: 80,
                            height: 80,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    '${weather?.temperature ?? '--'}°C',
                    style: const TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          weather?.name ?? _currentCity,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          weather?.main ?? "",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.95),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Wind: ${weather?.wind ?? '--'} m/s',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Lottie.asset(
                      'assets/${animal}.json',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SecondPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.9),
                        foregroundColor: Colors.blue,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Titta schema',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}