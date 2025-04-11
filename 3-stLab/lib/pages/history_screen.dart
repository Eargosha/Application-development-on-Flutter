import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inputs/pages/cubit/history_cubit.dart/history_cubit.dart';
import 'package:inputs/pages/cubit/history_cubit.dart/history_state.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('История вычислений'),
        centerTitle: true,
      ),
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          context.read<HistoryCubit>().loadCalculations();
          if (state is HistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HistoryError) {
            return Center(child: Text(state.message));
          }

          if (state is HistoryLoaded) {
            final calculations = state.calculations;

            if (calculations.isEmpty) {
              return const Center(child: Text('История пуста'));
            }

            return ListView.builder(
              itemCount: calculations.length,
              itemBuilder: (context, index) {
                final calc = calculations[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Ускорение: ${calc['acceleration'].toStringAsFixed(2)} м/с²',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                await context.read<HistoryCubit>().deleteFromDB(
                                      calc['id'],
                                    );
                              },
                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Начальная: ${calc['initialSpeed']} м/с',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Конечная: ${calc['finalSpeed']} м/с',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Время: ${calc['time']} с',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Расчет произведен: ${DateFormat('dd.MM.yyyy HH:mm').format(DateTime.parse(calc['timestamp']))}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text('Загрузите историю'));
        },
      ),
    );
  }
}