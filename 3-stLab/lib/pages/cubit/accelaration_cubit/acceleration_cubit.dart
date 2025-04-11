import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inputs/database_provider.dart';
import 'package:inputs/pages/cubit/accelaration_cubit/acceleration_state.dart';

// Сам кубит кубитим
class AccelerationCubit extends Cubit<AccelerationState> {
  // Конструктор. Устанавливает начальное состояние в инициализацию
  AccelerationCubit() : super(AccelerationInitial());

  // Вычисляет ускорение на основе начальной и конечной скорости, а также времени.
  // Если входные данные некорректны (отрицательные скорости или время <= 0),
  // переходит в состояние ошибки (AccelerationError).
  //
  // Параметры:
  //   - initialSpeed: начальная скорость (м/с)
  //   - finalSpeed: конечная скорость (м/с)
  //   - time: время (с)
  double? calculateAcceleration(
    double initialSpeed,
    double finalSpeed,
    double time,
  ) {
    if (initialSpeed < 0 || finalSpeed < 0 || time <= 0) {
      emit(
        AccelerationError(
          errorMessage: 'Некорректные входные данные в calculateAcceleration',
        ),
      );
      return -666;
    } else {
      double acceleration = (finalSpeed - initialSpeed) / time;
      emit(AccelerationCalculated(acceleration: acceleration));
      return acceleration;
    }
  }

  // Сохранение в локальную БД
  Future<int> saveToDB(Map<String, dynamic> calculation) async {
    return await DatabaseProvider.db.addCalculation(calculation);
  }

  void erraseState() {
    emit(AccelerationInitial());
  }
}
