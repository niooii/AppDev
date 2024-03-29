import 'package:flutter/material.dart';
import 'package:shaders_project/sphere_torus_shader.dart';
import 'package:shaders_project/sphere_infinite_shader.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShaderSwitcher()
    );
  }
}

class ShaderSwitcher extends StatefulWidget {
  ShaderSwitcher({super.key}) {
    shader = const SphereTorusShader();
  }

  late Widget shader;

  @override
  State<ShaderSwitcher> createState() => _ShaderSwitcherState();
}

class _ShaderSwitcherState extends State<ShaderSwitcher> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: widget.shader,
      onDoubleTap: () {
        setState(() {
          widget.shader = widget.shader is SphereTorusShader ? const SphereInfiniteShader() : const SphereTorusShader();
        });
      },
    );
  }
}