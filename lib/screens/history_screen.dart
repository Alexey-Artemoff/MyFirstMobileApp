import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/history_cubit.dart';
import 'cubit/history_state.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HistoryCubit()..loadHistory(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('История вычислений'),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: BlocBuilder<HistoryCubit, HistoryState>(
          builder: (context, state) {
            if (state is HistoryLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is HistoryErrorState) {
              return Center(
                child: Text(state.message),
              );
            }

            if (state is HistoryLoadedState) {
              if (state.calculations.isEmpty) {
                return const Center(
                  child: Text(
                    'История вычислений пуста',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }

              return ListView.builder(
                itemCount: state.calculations.length,
                itemBuilder: (context, index) {
                  final calculation = state.calculations[index];

                  final date = DateTime.tryParse(calculation.date);

                  final formattedDate = date == null
                      ? calculation.date
                      : '${date.day.toString().padLeft(2, '0')}.'
                        '${date.month.toString().padLeft(2, '0')}.'
                        '${date.year} '
                        '${date.hour.toString().padLeft(2, '0')}:'
                        '${date.minute.toString().padLeft(2, '0')}';

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.calculate),
                      ),
                      title: Text(
                        '(${calculation.a} + ${calculation.b})² = '
                        '${calculation.result}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'A = ${calculation.a}; '
                        'B = ${calculation.b}\n'
                        'Дата: $formattedDate',
                      ),
                      isThreeLine: true,
                      trailing: IconButton(
                        tooltip: 'Удалить запись',
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          context
                              .read<HistoryCubit>()
                              .deleteCalculation(calculation.id!);
                        },
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}