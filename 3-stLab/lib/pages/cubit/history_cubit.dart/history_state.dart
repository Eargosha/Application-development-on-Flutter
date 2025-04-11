// Состояния для HistoryCubit
abstract class HistoryState {}

// Инициализация
class HistoryInitial extends HistoryState {}

// Грузимся
class HistoryLoading extends HistoryState {}

// Загрузились
class HistoryLoaded extends HistoryState {
  final List<Map<String, dynamic>> calculations;
  
  HistoryLoaded(this.calculations);
}

// Ашибочкааа
class HistoryError extends HistoryState {
  final String message;
  
  HistoryError(this.message);
}