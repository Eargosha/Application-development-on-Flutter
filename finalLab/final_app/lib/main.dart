import 'package:final_app/cubit/weather_cubit/weather_cubit.dart';
import 'package:final_app/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Weather App",
        home: const MainScreen(),
      ),
    );
  }
}