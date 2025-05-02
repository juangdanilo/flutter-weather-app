import 'package:flutter_test/flutter_test.dart';
import 'package:simple_weather/weather_models/weather_model.dart';

void main() {
  test('Weather.fromJson should parse the correct JSON', () {
    // JSON simulado de la API
    final Map<String, dynamic> json = {
      'name': 'Bogotá',
      'main': {'temp': 18.5},
      'weather': [
        {'main': 'Clouds'}
      ]
    };

    // Parse Json
    final weather = Weather.fromJson(json);

    // Verify the correct values
    expect(weather.cityName, 'Bogotá');
    expect(weather.temperature, 18.5);
    expect(weather.description, 'Clouds');
  });
}