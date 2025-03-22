// Абстрактное состояние кубита
abstract class AccelerationState {}

// Состояние инициализации
class AccelerationInitial extends AccelerationState {}

// Состояние для работы с самим ускорением
class AccelerationCalculated extends AccelerationState {
  final double acceleration;

  AccelerationCalculated({required this.acceleration});
}

// Состояние для работы с ошибками
class AccelerationError extends AccelerationState {
  final String errorMessage;

  AccelerationError({required this.errorMessage});
}
