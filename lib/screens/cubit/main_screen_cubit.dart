import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(MainScreenInitialState());

  void Calculate(String aText, String bText) {
    int a = int.parse(aText);
    int b = int.parse(bText);

    int result = (a + b) * (a + b);

    emit(MainScreenResultState(result: result));
  }

  void reset() {
    emit(MainScreenInitialState());
  }
}