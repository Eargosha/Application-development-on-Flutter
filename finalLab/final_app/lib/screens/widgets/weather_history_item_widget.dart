import 'package:final_app/models/weather_model.dart';
import 'package:flutter/material.dart';

Widget buildHistoryItem(Weather weather) {
  return ListTile(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    tileColor: Colors.grey,
    leading: Image.network(weather.iconUrl, width: 40, height: 40),
    title: Text(weather.name),
    subtitle: Text(
      '${weather.main.temp.round()}°C, ${weather.weather.first.description}',
    ),
    trailing: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Дождь: ${(weather.pop * 100).toStringAsFixed(0)}%'),
        if (weather.rain != null)
          Text(
            'Осадки: ${weather.rain!.last1h} мм',
            style: const TextStyle(fontSize: 12),
          ),
      ],
    ),
  );
}
