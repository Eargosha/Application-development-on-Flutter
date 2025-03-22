import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inputs/pages/cubit/acceleration_cubit.dart';
import 'package:inputs/pages/cubit/acceleration_state.dart';

class SecondScreen extends StatelessWidget {
  SecondScreen();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Результат расчета')),
      body: BlocBuilder<AccelerationCubit, AccelerationState>(
        builder: (context, state) {
          if (state is AccelerationInitial) {
            return Center(child: Text('Введите данные для расчета ускорения'));
          } else if (state is AccelerationCalculated) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.acceleration < 0
                        ? 'Торможение: ${state.acceleration.toStringAsFixed(2)} м/с²'
                        : 'Ускорение: ${state.acceleration.toStringAsFixed(2)} м/с²',
                    style: TextStyle(fontSize: 18),
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
            );
          } else if (state is AccelerationError) {
            return Center(
              child: Text(
                state.errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          } else {
            return Center(
              child: Text('Чет непонятное произошло, че ты наделал?!'),
            );
          }
        },
      ),
    );
  }
}
