// lib/weather_widget.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_forecast_app/weather_provide.dart';

class WeatherDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weather = Provider.of<WeatherProvider>(context).weather;

    return Column(
      children: [
        Text(
          weather!.cityName,
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          '${weather.temperature.toStringAsFixed(1)}°C',
          style: TextStyle(fontSize: 40, color: Colors.white),
        ),
        Text(
          weather.description,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ],
    );
  }
}
