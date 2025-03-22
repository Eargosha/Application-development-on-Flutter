import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inputs/pages/cubit/acceleration_cubit.dart';

import 'pages/first_screen_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccelerationCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Лаб. раб №3, калькулятор ускорения',
        theme: ThemeData(primarySwatch: Colors.green),
        home: FirstScreen(),
      ),
    );
  }
}
