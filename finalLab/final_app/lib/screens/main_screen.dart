import 'package:final_app/screens/calculatror_screen.dart';
import 'package:final_app/screens/developer_screen.dart';
import 'package:final_app/screens/weather_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главное меню')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WeatherScreen()),
              ),
              child: const Text('Погода и прогноз дождя'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CalculatorScreen()),
              ),
              child: const Text('Интерпретация осадков'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DeveloperScreen()),
              ),
              child: const Text('Информация о разработчике'),
            ),
          ],
        ),
      ),
    );
  }
}