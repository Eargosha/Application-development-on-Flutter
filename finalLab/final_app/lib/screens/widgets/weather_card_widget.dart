import 'package:final_app/models/weather_model.dart';
import 'package:final_app/screens/widgets/weather_info_widget.dart';
import 'package:flutter/material.dart';

Widget buildWeatherCard(Weather weather) {
  return Card(
    color: Colors.grey,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(weather.name, style: const TextStyle(fontSize: 24)),
          Text('${weather.sys.country}', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(weather.iconUrl, width: 100, height: 100),
              Text(
                weather.main.temp.round().toString(),
                style: const TextStyle(fontSize: 54),
              ),
              const Text('°C', style: TextStyle(fontSize: 48)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            weather.weather.first.description,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          Text(
            'Ощущается как ${weather.main.feelsLike.round()}°C',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildWeatherInfoItem(
                Icons.water_drop,
                'Влажность',
                '${weather.main.humidity}%',
              ),
              buildWeatherInfoItem(
                Icons.air,
                'Ветер',
                '${weather.wind.speed} м/с',
              ),
              buildWeatherInfoItem(
                Icons.speed,
                'Давление',
                '${weather.main.pressure} гПа',
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Вероятность дождя: ${(weather.pop * 100).toStringAsFixed(0)}%',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: weather.pop,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          if (weather.rain != null) ...[
            const SizedBox(height: 10),
            Text(
              'Осадки за последний час: ${weather.rain!.last1h} мм',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ],
      ),
    ),
  );
}
