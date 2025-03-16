import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: Text(
            'Лабораторная работа №2',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: 'Georgia',
            ),
          ),
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          spacing: 8.0,
          runSpacing: 16.0,
          children: List.generate(10, (index) {
            return Container(
              width: math.Random().nextDouble() * 100 + 50,
              height: math.Random().nextDouble() * 100 + 50,
              decoration: BoxDecoration(
                color: Colors.primaries[index % Colors.primaries.length],
                border: Border(
                  bottom: BorderSide(
                    width: 6,
                    color: const Color.fromARGB(151, 255, 255, 255),
                  ),
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: Icon(Icons.android_rounded, size: 40, color: Colors.white),
            );
          }),
        ),
      ),
    );
  }
}
