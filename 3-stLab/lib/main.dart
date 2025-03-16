import 'package:flutter/material.dart';

import 'pages/first_screen_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Лаб. раб №3, калькулятор ускорения',
      theme: ThemeData(primarySwatch: Colors.green),
      home: FirstScreen(),
    );
  }
}
