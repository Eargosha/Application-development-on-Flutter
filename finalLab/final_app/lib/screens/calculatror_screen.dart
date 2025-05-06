import 'package:final_app/cubit/weather_cubit/weather_cubit.dart';
import 'package:final_app/cubit/weather_cubit/weather_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Интерпретация осадков')),
      body: const CalculatorContent(),
    );
  }
}

class CalculatorContent extends StatefulWidget {
  const CalculatorContent({super.key});

  @override
  State<CalculatorContent> createState() => _CalculatorContentState();
}

class _CalculatorContentState extends State<CalculatorContent> {
  final TextEditingController _precipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _precipController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Процент осадков',
              hintText: 'Введите значение от 0 до 100',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final value = double.tryParse(_precipController.text);
              if (value != null) {
                context.read<WeatherCubit>().interpretPrecipitation(value);
              }
            },
            child: const Text('Интерпретировать'),
          ),
          const SizedBox(height: 20),
          BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
              if (state is WeatherPrecipitationInterpretedState) {
                return Text(
                  state.interpretation,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                );
              } else if (state is WeatherErrorState) {
                return Text(
                  state.message,
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                  textAlign: TextAlign.center,
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}