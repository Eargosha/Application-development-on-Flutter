import 'package:rover_mars/models/nasa_model.dart';

abstract class NasaState {}

class NasaLoadingState extends NasaState {}

class NasaLoadedState extends NasaState {
  Nasa data;
  NasaLoadedState({required this.data});
}

class NasaErrorState extends NasaState {}
