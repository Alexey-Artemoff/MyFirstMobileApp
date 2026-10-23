import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/main_screen_cubit.dart';
import 'cubit/main_screen_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _agreement = false;

  final _aController = TextEditingController();
  final _bController = TextEditingController();

  @override
  void dispose() {
    _aController.dispose();
    _bController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Артёмов Алексей Андреевич',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: BlocBuilder<MainScreenCubit, MainScreenState>(
        builder: (context, state) {
          if (state is MainScreenResultState) {
            return _buildResult(state);
          }

          return _buildForm();
        },
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text(
              "Введите число A:",
              style: TextStyle(fontSize: 20.0),
            ),

            TextFormField(
              controller: _aController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Введите число A!";
                }

                if (int.tryParse(value) == null) {
                  return "Введите целое число!";
                }

                return null;
              },
            ),

            const SizedBox(height: 20.0),

            const Text(
              "Введите число B:",
              style: TextStyle(fontSize: 20.0),
            ),

            TextFormField(
              controller: _bController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Введите число B!";
                }

                if (int.tryParse(value) == null) {
                  return "Введите целое число!";
                }

                return null;
              },
            ),

            const SizedBox(height: 20.0),

            CheckboxListTile(
              value: _agreement,
              title: const Text(
                "Я ознакомлен и согласен с документом "
                "'Согласие на обработку персональных данных'.",
              ),
              onChanged: (bool? value) {
                setState(() {
                  _agreement = value ?? false;
                });
              },
            ),

            const SizedBox(height: 20.0),

            ElevatedButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }

                if (!_agreement) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Необходимо согласиться на обработку персональных данных",
                      ),
                    ),
                  );
                  return;
                }

                context.read<MainScreenCubit>().Calculate(
                      _aController.text,
                      _bController.text,
                    );
              },
              child: const Text(
                "Рассчитать квадрат суммы",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResult(MainScreenResultState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Ваш результат: ${state.result}",
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<MainScreenCubit>().reset();
            },
            child: const Text(
              "Назад",
            ),
          ),
        ],
      ),
    );
  }
}