import 'package:final_app/models/weather_model.dart';

abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final Weather weather;
  final List<Weather> history;
  
  WeatherLoadedState({required this.weather, required this.history});
}

class WeatherPrecipitationInterpretedState extends WeatherState {
  final String interpretation;
  
  WeatherPrecipitationInterpretedState({required this.interpretation});
}

class WeatherErrorState extends WeatherState {
  final String message;
  
  WeatherErrorState({required this.message});
}