// lib/service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_forecast_app/weather.dart';

class WeatherService {
  final String apiKey = '84502530ce0d8f7bb84b9db7351c2f72';

  Future<Weather> fetchWeather(String city) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey'));

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
