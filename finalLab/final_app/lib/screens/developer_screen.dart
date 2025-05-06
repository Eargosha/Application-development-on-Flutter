import 'package:flutter/material.dart';

class DeveloperScreen extends StatelessWidget {
  const DeveloperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Информация о разработчике')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              // Грузим с гитхаба аватарку. Не думаю, что в скором времени аватарки с гитхаба не будут работать
              backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/146343122?v=4'),
            ),
            const SizedBox(height: 20),
            const Text('Иванов Егор Николаевич', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 10),
            const Text('Группа: ИВТ-22', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            const Text('Контакты: eargosha@mail.ru', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Назад'),
            ),
          ],
        ),
      ),
    );
  }
}