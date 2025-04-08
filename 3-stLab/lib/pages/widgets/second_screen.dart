import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inputs/pages/cubit/acceleration_cubit.dart';

class SecondScreen extends StatelessWidget {
  SecondScreen({required this.acceleration});

  final double acceleration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Результат расчета',
            style: TextStyle(fontSize: 32)
          ),
          const SizedBox(height: 32),
          Text(
            acceleration < 0
                ? 'Торможение: ${acceleration.toStringAsFixed(2)} м/с²'
                : 'Ускорение: ${acceleration.toStringAsFixed(2)} м/с²',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.read<AccelerationCubit>().erraseState();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Назад'),
            ),
          ),
        ],
      ),
    );
  }
}