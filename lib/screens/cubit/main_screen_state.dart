abstract class MainScreenState {}

class MainScreenInitialState extends MainScreenState {}

class MainScreenResultState extends MainScreenState {
  final int result;

  MainScreenResultState({required this.result,});
}