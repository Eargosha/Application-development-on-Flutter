import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final double initialSpeed;
  final double finalSpeed;
  final double time;

  SecondScreen({
    required this.initialSpeed,
    required this.finalSpeed,
    required this.time,
  });

  String? validateInputs() {
    if (initialSpeed < 0) {
      return 'Начальная скорость не может быть отрицательной';
    }
    if (finalSpeed < 0) {
      return 'Конечная скорость не может быть отрицательной';
    }
    if (time <= 0) {
      return 'Время должно быть больше нуля';
    }
    return null;
  }

  double calculateAcceleration() {
    return (finalSpeed - initialSpeed) / time;
  }

  @override
  Widget build(BuildContext context) {
    double acceleration = calculateAcceleration();
    String? validationError = validateInputs();

    return Scaffold(
      appBar: AppBar(
        title: Text(validationError == null ? 'Результат расчета' : 'Ошибка'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (validationError == null)
              Text(
                acceleration < 0
                    ? 'Торможение: ${acceleration.toStringAsFixed(2)} м/с²'
                    : 'Ускорение: ${acceleration.toStringAsFixed(2)} м/с²',
                style: TextStyle(fontSize: 18),
              )
            else
              Text(
                validationError,
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Назад'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
