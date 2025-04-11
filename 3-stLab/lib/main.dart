import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inputs/pages/cubit/accelaration_cubit/acceleration_cubit.dart';
import 'package:inputs/pages/cubit/history_cubit.dart/history_cubit.dart';

import 'pages/screen_provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AccelerationCubit()),
        BlocProvider(create: (context) => HistoryCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Калькулятор ускорения',
        theme: ThemeData(primarySwatch: Colors.green),
        home: ScreenProvider(),
      ),
    );
  }
}
