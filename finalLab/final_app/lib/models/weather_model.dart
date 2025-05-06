import 'package:final_app/models/clouds_model.dart';
import 'package:final_app/models/coordinates_model.dart';
import 'package:final_app/models/main_weather_data_model.dart';
import 'package:final_app/models/rain_model.dart';
import 'package:final_app/models/sys_model.dart';
import 'package:final_app/models/weather_conditions_model.dart';
import 'package:final_app/models/wind_model.dart';

class Weather {
  final Coordinates coord;
  final List<WeatherCondition> weather;
  final MainWeatherData main;
  final int visibility;
  final Wind wind;
  final Rain? rain;
  final Clouds clouds;
  final int dt;
  final String name;
  final int timezone;
  final Sys sys;
  final double pop; // Вероятность осадков (0..1)

  Weather({
    required this.coord,
    required this.weather,
    required this.main,
    required this.visibility,
    required this.wind,
    this.rain,
    required this.clouds,
    required this.dt,
    required this.name,
    required this.timezone,
    required this.sys,
    required this.pop,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      coord: Coordinates.fromJson(json['coord'] ?? {}),
      weather:
          (json['weather'] as List? ?? [])
              .map((e) => WeatherCondition.fromJson(e ?? {}))
              .toList(),
      main: MainWeatherData.fromJson(json['main'] ?? {}),
      visibility: json['visibility'] ?? 0,
      wind: Wind.fromJson(json['wind'] ?? {}),
      rain:
          (json.containsKey('rain') && json['rain'] != null)
              ? Rain.fromJson(json['rain'])
              : null,
      clouds: Clouds.fromJson(json['clouds'] ?? {}),
      dt: json['dt'] ?? 0,
      name: json['name'] ?? '',
      timezone: json['timezone'] ?? 0,
      sys: Sys.fromJson(json['sys'] ?? {}),
      pop: json['pop']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coord': coord.toJson(),
      'weather': weather.map((e) => e.toJson()).toList(),
      'main': main.toJson(),
      'visibility': visibility,
      'wind': wind.toJson(),
      'rain': rain?.toJson(),
      'clouds': clouds.toJson(),
      'dt': dt,
      'name': name,
      'timezone': timezone,
      'sys': sys.toJson(),
      'pop': pop,
    };
  }

  // Вспомогательные геттеры для удобства
  String get temperature => '${main.temp.round()}°C';
  String get feelsLike => 'Ощущается как ${main.feelsLike.round()}°C';
  String get description => weather.first.description;
  String get iconUrl =>
      'https://openweathermap.org/img/wn/${weather.first.icon}@2x.png';
  String get precipitation => rain != null ? '${rain!.last1h} мм' : '0 мм';
  String get humidity => '${main.humidity}%';
  String get windSpeed => '${wind.speed} м/с';
  String get pressure => '${main.pressure} гПа';
  double get precipProbability => pop;
}
