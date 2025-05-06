import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> getWeatherData(String cityName) async {
  const API_KEY = "6e8f57a9bb1328548a237669006646b7";

  final currentWeatherUrl = Uri.parse(
    'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$API_KEY&units=metric&lang=ru',
  );

  final forecastUrl = Uri.parse(
    'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$API_KEY&units=metric&lang=ru&cnt=5',
  );

  try {
    final [currentResponse, forecastResponse] = await Future.wait([
      http.get(currentWeatherUrl),
      http.get(forecastUrl),
    ]);

    if (currentResponse.statusCode == 200 && forecastResponse.statusCode == 200) {
      final currentData = json.decode(currentResponse.body);
      final forecastData = json.decode(forecastResponse.body);

      // Тут появились некотрые беды с получением процента возможных осадков, т.к. иногда 
      // По описанию пишет дождь, а json поле 'pop' равно 0, т.е. типо нет осадков
      // Вот логика в несколько этапов, где можно узнать примерно о возможности дождя
      // 1. Проверяем текущую погоду на наличие дождя
      final currentWeather = currentData['weather'][0];
      final isCurrentlyRaining = currentWeather['main'] == 'Rain' || 
                                 currentWeather['main'] == 'Snow' ||
                                 currentWeather['main'] == 'Drizzle';

      // 2. Получаем вероятность осадков из ближайшего прогноза
      double pop = forecastData['list'][0]?['pop']?.toDouble() ?? 0.0;

      // 3. Проверяем наличие осадков в прогнозе
      final forecastWeather = forecastData['list'][0]['weather'][0];
      final isForecastRain = forecastWeather['main'] == 'Rain' || 
                           forecastWeather['main'] == 'Snow' ||
                           forecastWeather['main'] == 'Drizzle';

      // 4. Если сейчас дождь или в прогнозе дождь, но pop=0, корректируем значение
      if ((isCurrentlyRaining || isForecastRain) && pop == 0) {
        pop = 0.5; // Устанавливаем среднюю вероятность
      }

      // 5. Если есть данные об осадках за последний час, увеличиваем вероятность
      if (currentData.containsKey('rain') && currentData['rain'] != null) {
        final rainVolume = currentData['rain']['1h'] ?? 0.0;
        if (rainVolume > 0) {
          pop = max(pop, 0.7); // Минимум 70% если есть осадки
        }
      }

      return {...currentData, 'pop': pop};
    } else {
      throw Exception('Ошибка запроса: ${currentResponse.statusCode} / ${forecastResponse.statusCode}');
    }
  } catch (e) {
    throw Exception('Ошибка: $e');
  }
}