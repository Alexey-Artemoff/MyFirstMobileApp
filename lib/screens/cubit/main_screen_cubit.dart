import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../database/db_provider.dart';
import '../../models/calculation.dart';
import 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(MainScreenInitialState());

  Future<void> calculate(
    String aText,
    String bText,
  ) async {
    final int a = int.parse(aText);
    final int b = int.parse(bText);

    final int result = (a + b) * (a + b);

    final calculation = Calculation(
      a: a,
      b: b,
      result: result,
      date: DateTime.now().toIso8601String(),
    );

    await DBProvider.db.insertCalculation(calculation);

    emit(MainScreenResultState(result: result));
  }

  Future<void> saveAgreement(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('agreement', value);
  }

  Future<bool> loadAgreement() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool('agreement') ?? false;
  }

  void reset() {
    emit(MainScreenInitialState());
  }
}