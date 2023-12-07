import 'package:flutter/material.dart';

class Alarm extends StatelessWidget {
  const Alarm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "RING RING",
      style: TextStyle(
        fontSize: 65,
        fontWeight: FontWeight.bold
      )
    );
  }
}