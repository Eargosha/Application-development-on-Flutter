import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rover_mars/screens/photos_screen.dart';
import 'cubit/nasa_cubit.dart'; // Impo

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Nasa Rover",
      home: BlocProvider(
        create: (context) => NasaCubit()..loadData(),
        child: const PhotosScreen(),
      ),
    );
  }
}
