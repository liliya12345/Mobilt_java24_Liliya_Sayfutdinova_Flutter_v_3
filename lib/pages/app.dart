import 'package:flutter/material.dart';
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
      home: const WeatherApp(), // Теперь WeatherApp является home, а не вложенным MaterialApp
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
  String _currentCity = 'Lund';
  String animal = '';
  bool isSchool = true;

  void getData() async {
    try {
      String city = await getCurrentCity();
      final data = await getWeatherData(city);
      setState(() {
        weather = data;
        _currentCity = city;
      });
    } catch (e) {
      print('Error: $e');
      final data = await getWeatherData(_currentCity);
      setState(() {
        weather = data;
      });
    }
  }

  Future<void> _searchCity() async {
    final city = _searchController.text.trim();
    if (city.isNotEmpty) {
      setState(() {
        weather = null;
      });

      try {
        final data = await getWeatherData(city);
        setState(() {
          weather = data;
          _currentCity = city;
        });
      } catch (e) {
        print('Error searching city: $e');
      }

      _searchController.clear();
    }
  }

  Color getColorOfDay(DateTime dateTime) {
    final day = DateFormat('EEEE').format(dateTime);
    switch(day) {
      case 'Saturday':
        isSchool = false;
        return const Color(0xFFEDA547);
      case 'Sunday':
        isSchool = false;
        return const Color(0xFFF19724);
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
        animal = 'yay';
        animation = 'assets/snow.json';
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
    return Scaffold( // Убрали MaterialApp, теперь используем Scaffold
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
        child: weather == null
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
                  // Дата и анимация погоды на одной строке
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Дата и время
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

                        // Погодная анимация
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

                  // Температура (отдельный блок)
                  Text(
                    '${weather?.temperature ?? '--'}°C',
                    style: const TextStyle(
                      fontSize: 64,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Город и погода (отдельный блок)
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
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          weather?.main ?? "",
                          style: TextStyle(
                            fontSize: 20,
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

                  const SizedBox(height: 40),

                  // Анимация животного
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Lottie.asset(
                      'assets/${animal}.json',
                      width: 280,
                      height: 280,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Кнопка перехода на вторую страницу
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