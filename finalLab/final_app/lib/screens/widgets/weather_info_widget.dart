import 'package:flutter/material.dart';

Widget buildWeatherInfoItem(IconData icon, String label, String value) {
  return Column(
    children: [
      Icon(icon, size: 30),
      const SizedBox(height: 5),
      Text(label, style: const TextStyle(fontSize: 14)),
      Text(value, style: const TextStyle(fontSize: 16)),
    ],
  );
}
