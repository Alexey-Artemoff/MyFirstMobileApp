import '../../models/calculation.dart';

abstract class HistoryState {}

class HistoryInitialState extends HistoryState {}

class HistoryLoadingState extends HistoryState {}

class HistoryLoadedState extends HistoryState {
  final List<Calculation> calculations;

  HistoryLoadedState({
    required this.calculations,
  });
}

class HistoryErrorState extends HistoryState {
  final String message;

  HistoryErrorState({
    required this.message,
  });
}