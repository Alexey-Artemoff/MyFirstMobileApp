import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/db_provider.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitialState());

  Future<void> loadHistory() async {
    emit(HistoryLoadingState());

    try {
      final calculations =
          await DBProvider.db.getAllCalculations();

      emit(
        HistoryLoadedState(
          calculations: calculations,
        ),
      );
    } catch (e) {
      emit(
        HistoryErrorState(
          message: 'Не удалось загрузить историю',
        ),
      );
    }
  }

  Future<void> deleteCalculation(int id) async {
    try {
      await DBProvider.db.deleteCalculation(id);

      await loadHistory();
    } catch (e) {
      emit(
        HistoryErrorState(
          message: 'Не удалось удалить запись',
        ),
      );
    }
  }
}