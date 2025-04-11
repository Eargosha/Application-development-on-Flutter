import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inputs/database_provider.dart';
import 'package:inputs/pages/cubit/history_cubit.dart/history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  Future<void> loadCalculations() async {
    try {
      emit(HistoryLoading());

      final calculations = await DatabaseProvider.db.getAllCalculations();

      emit(HistoryLoaded(calculations));
    } catch (e) {
      emit(HistoryError('Ошибка загрузки истории: $e'));
    }
  }

  Future<void> clearHistory() async {
    try {
      emit(HistoryLoading());
      await DatabaseProvider.db.clearAllCalculations();
      loadCalculations();
    } catch (e) {
      emit(HistoryError('Ошибка очистки истории: $e'));
    }
  }

  // Удаление с локлаьной БД
  Future<int> deleteFromDB(int id) async {
    try {
      emit(HistoryLoading());
      int resultOfDeletion = await DatabaseProvider.db.deleteCalculation(id);
      loadCalculations();
      return resultOfDeletion;
    } catch (e) {
      emit(HistoryError('Ошибка удаления: $e'));
      return -666;
    }
  }
}
