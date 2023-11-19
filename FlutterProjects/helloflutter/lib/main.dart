import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('first appbar'),
        ),
        body: const Center(
          child: Text('Hello World!'),
        ),
        drawer: const Drawer(
          child: Center(
            child: Text('I AM DRAWER')
          ),
        ),
      ),
    );
  }
}
