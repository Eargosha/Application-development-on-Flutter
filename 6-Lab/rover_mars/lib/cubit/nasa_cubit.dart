import 'package:rover_mars/cubit/nasa_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rover_mars/models/nasa_model.dart';
import 'package:rover_mars/requests/nasa_api.dart';

class NasaCubit extends Cubit<NasaState> {
  NasaCubit() : super(NasaLoadingState());

  Future<void> loadData() async {
    try {
      Map<String, dynamic> apiData = await getNasaData();
      Nasa nasaData = Nasa.fromJson(apiData);
      emit(NasaLoadedState(data: nasaData));
      return;
    } catch (e) {
      emit(NasaErrorState());
      return;
    }
  }
}
