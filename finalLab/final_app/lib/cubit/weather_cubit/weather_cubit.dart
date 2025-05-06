import 'dart:convert';

import 'package:final_app/cubit/weather_cubit/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_app/models/weather_model.dart';
import 'package:final_app/requests/weather_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitialState());

  // Получение данных о погоде
  Future<void> fetchWeather(String location) async {
    emit(WeatherLoadingState());

    try {
      // Получаем данные о погоде
      final weatherData = await getWeatherData(location);
      final weather = Weather.fromJson(weatherData);

      // Работа SharedPreferences, храним значения о погоде как json строки
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getStringList('weather_history') ?? [];
      historyJson.add(jsonEncode(weather.toJson()));
      await prefs.setStringList('weather_history', historyJson);

      final history =
          historyJson
              .map((e) => Weather.fromJson(jsonDecode(e)))
              .toList()
              .reversed
              .toList();

      emit(WeatherLoadedState(weather: weather, history: history));
    } catch (e, stacktrace) {
      print("Error occurred: $e");
      print("Stacktrace: $stacktrace");
      emit(WeatherErrorState(message: 'Не удалось получить данные: $e'));
    }
  }

  // Получение даных о Интерпретация % осадков.
  void interpretPrecipitation(double value) {
    if (value < 0 || value > 100) {
      emit(WeatherErrorState(message: 'Введите значение от 0 до 100'));
      return;
    }

    String interpretation;
    if (value == 0) {
      interpretation = 'Осадков не ожидается';
    } else if (value <= 20) {
      interpretation =
          'Небольшая вероятность осадков, можно обойтись без зонта';
    } else if (value <= 50) {
      interpretation =
          'Есть вероятность осадков, возьмите зонт на всякий случай';
    } else if (value <= 80) {
      interpretation = 'Высокая вероятность осадков, лучше взять зонт';
    } else {
      interpretation =
          'Очень высокая вероятность осадков, обязательно возьмите зонт';
    }

    emit(WeatherPrecipitationInterpretedState(interpretation: interpretation));
  }
}
