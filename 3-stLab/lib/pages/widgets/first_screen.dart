import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inputs/pages/cubit/acceleration_cubit.dart';

// Виджеты для body ввода данных
class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _formKey = GlobalKey<FormState>();

  final _initialSpeedField = TextEditingController();
  final _finalSpeedField = TextEditingController();
  final _timeField = TextEditingController();

  bool isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Калькулятор ускорения',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            TextFormField(
              controller: _initialSpeedField,
              decoration: InputDecoration(
                labelText: 'Начальная скорость (м/с)',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Пожалуйста, введите начальную скорость';
                }
                if (double.tryParse(value) == null) {
                  return 'Введите корректное число';
                }
                if (double.parse(value) < 0) {
                  return 'Скорость не может быть отрицательной';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _finalSpeedField,
              decoration: InputDecoration(labelText: 'Конечная скорость (м/с)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Пожалуйста, введите конечную скорость';
                }
                if (double.tryParse(value) == null) {
                  return 'Введите корректное число';
                }
                if (double.parse(value) < 0) {
                  return 'Скорость не может быть отрицательной';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _timeField,
              decoration: InputDecoration(labelText: 'Время (с)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Пожалуйста, введите время';
                }
                if (double.tryParse(value) == null) {
                  return 'Введите корректное число';
                }
                if (double.parse(value) <= 0) {
                  return 'Время должно быть больше нуля';
                }
                return null;
              },
            ),
            CheckboxListTile(
              title: Text('Согласен на обработку данных'),
              value: isAgreed,
              onChanged: (value) {
                setState(() {
                  isAgreed = value!;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && isAgreed) {
                    _formKey.currentState!.save();

                    final initialSpeed = double.parse(_initialSpeedField.text);
                    final finalSpeed = double.parse(_finalSpeedField.text);
                    final time = double.parse(_timeField.text);

                    context.read<AccelerationCubit>().calculateAcceleration(
                      initialSpeed,
                      finalSpeed,
                      time,
                    );
                  } else if (!isAgreed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Необходимо согласие на обработку данных',
                        ),
                      ),
                    );
                  }
                },
                child: Text('Рассчитать ускорение'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
