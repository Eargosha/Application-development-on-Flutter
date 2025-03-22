import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inputs/pages/cubit/acceleration_state.dart';

// Сам кубит кубитим
class AccelerationCubit extends Cubit<AccelerationState> {
  // Конструктор. Устанавливает начальное состояние с ускорением, равным 0.
  AccelerationCubit() : super(AccelerationCalculated(acceleration: 0));

  // Вычисляет ускорение на основе начальной и конечной скорости, а также времени.
  // Если входные данные некорректны (отрицательные скорости или время <= 0),
  // переходит в состояние ошибки (AccelerationError).
  //
  // Параметры:
  //   - initialSpeed: начальная скорость (м/с)
  //   - finalSpeed: конечная скорость (м/с)
  //   - time: время (с)
  void calculateAcceleration(
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
    } else {
      double acceleration = (finalSpeed - initialSpeed) / time;
      emit(AccelerationCalculated(acceleration: acceleration));
    }
  }
}
