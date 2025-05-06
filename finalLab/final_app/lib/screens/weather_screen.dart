import 'package:final_app/cubit/weather_cubit/weather_cubit.dart';
import 'package:final_app/cubit/weather_cubit/weather_state.dart';
import 'package:final_app/screens/widgets/weather_card_widget.dart';
import 'package:final_app/screens/widgets/weather_history_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Погода и прогноз дождя')),
      body: const WeatherContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openRadar(context),
        tooltip: 'Открыть радар осадков',
        child: const Icon(Icons.map),
      ),
    );
  }

  // Функция включения радара, проверить особо не смог, т.к. у меня комп умирает, если открыть браузер в эмуляторе Android
  // Без понятия почему так происходит, мб инструкций Xeon'у не хватает.
  static void _openRadar(BuildContext context) async {
    const url = 'https://yandex.ru/pogoda/ru/maps/nowcast';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось открыть радар осадков')),
      );
    }
  }
}

class WeatherContent extends StatefulWidget {
  const WeatherContent({super.key});

  @override
  State<WeatherContent> createState() => _WeatherContentState();
}

class _WeatherContentState extends State<WeatherContent> {
  final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: 'Местоположение',
                    hintText: 'Введите город',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  if (_locationController.text.isNotEmpty) {
                    context.read<WeatherCubit>().fetchWeather(
                      _locationController.text,
                    );
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
              if (state is WeatherInitialState) {
                return const Center(
                  child: Text('Введите местоположение для получения погоды'),
                );
              } else if (state is WeatherLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is WeatherErrorState) {
                return Center(child: Text('Ошибка: ${state.message} Проверьте название города'));
              } else if (state is WeatherLoadedState) {
                return Expanded(
                  child: Column(
                    children: [
                      buildWeatherCard(state.weather),
                      const SizedBox(height: 20),
                      const Text(
                        'История запросов',
                        style: TextStyle(fontSize: 18),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.history.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: buildHistoryItem(state.history[index]),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
