import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_weather/weather_services/weather_service.dart';
import 'package:simple_weather/weather_models/weather_model.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('API KEY HERE');
  Weather? _weather;

  _fetchWeather() async {
    String city = await _weatherService.getCurrentCity();

    try{
      final weather = await _weatherService.fetchWeather(city);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  // WEATHER ANIMATIONS
String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/sun.json';
    }

    switch (mainCondition.toLowerCase()) {
      case 'Clear':
        return 'assets/sun.json';
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'fog':
      case 'Clouds':
        return 'assets/cloud.json';
      case 'Rain':
      case 'Drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'Thunderstorm':
        return 'assets/thunder.json';
      default:
        return 'assets/sun.json';
    }
  }
  // init state

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 160.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.black,
                      size: 30,
                    ),
                    Text(
                      _weather?.cityName ?? 'Loading city...',
                      style: GoogleFonts.merriweatherSans(
                        textStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),

            // animation
            Lottie.asset(getWeatherAnimation(_weather?.description)),

            Spacer(),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 160.0),
                child: Text(
                  '${_weather?.temperature.round()}°C',
                    style: GoogleFonts.merriweatherSans(
                      textStyle: TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}