// lib/weather_provide.dart

import 'package:flutter/material.dart';
import 'package:weather_forecast_app/service.dart';
import 'package:weather_forecast_app/weather.dart';

class WeatherProvider with ChangeNotifier {
  WeatherService _weatherService = WeatherService();
  Weather? _weather;

  Weather? get weather => _weather;

  Future<void> fetchWeather(String city) async {
    try {
      _weather = await _weatherService.fetchWeather(city);
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }
}
