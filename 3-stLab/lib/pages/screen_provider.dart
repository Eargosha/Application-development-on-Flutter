import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inputs/pages/cubit/accelaration_cubit/acceleration_cubit.dart';
import 'package:inputs/pages/cubit/accelaration_cubit/acceleration_state.dart';
import 'package:inputs/pages/history_screen.dart';
import 'package:inputs/pages/widgets/first_screen.dart';

import 'widgets/second_screen.dart';

class ScreenProvider extends StatefulWidget {
  @override
  _ScreenProviderState createState() => _ScreenProviderState();
}

class _ScreenProviderState extends State<ScreenProvider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Калькулятор ускорения',
          style: TextStyle(fontSize: 21),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HistoryScreen()),
            );
          },
          icon: Icon(Icons.history),
        ),
      ),
      body: BlocBuilder<AccelerationCubit, AccelerationState>(
        builder: (context, state) {
          if (state is AccelerationInitial) {
            return FirstScreen();
          } else if (state is AccelerationCalculated) {
            return SecondScreen(acceleration: state.acceleration);
          } else if (state is AccelerationError) {
            return Center(
              child: Text(
                state.errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          } else {
            return Center(
              child: Column(
                children: [
                  Text('Чет непонятное произошло, че ты наделал?!'),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
