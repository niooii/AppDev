import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShaderView()
    );
  }
}

class vec3 {
  vec3(this.x, this.y, this.z);

  double x, y, z;
}

class ShaderPainter extends CustomPainter {
  final FragmentShader shader;
  final double time;
  final vec3 cameraPos;

  ShaderPainter(FragmentShader fragmentShader, this.time, this.cameraPos)
      : shader = fragmentShader;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, time);
    //camerapos
    shader.setFloat(3, cameraPos.x);
    shader.setFloat(4, cameraPos.y);
    shader.setFloat(5, cameraPos.z);
    paint.shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ShaderView extends StatefulWidget {
  const ShaderView({super.key});

  @override
  State<ShaderView> createState() => _ShaderViewState();
}

class _ShaderViewState extends State<ShaderView> {
  late Timer timer;
  double delta = 0;
  vec3 cameraPos = vec3(0.0, 0.0, -3.0);
  double torusRot = 0.0;
  FragmentShader? shader;

  void loadShader() async {
    var program = await FragmentProgram.fromAsset('shaders/sphere_torus.frag');
    shader = program.fragmentShader();
    setState(() {
      // triggers repaint
    });

    timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        delta += 1 / 60;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadShader();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (shader == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return CustomPaint(
          painter: ShaderPainter(shader!, delta, cameraPos),
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              setState(() {
                delta += details.delta.dy / 25;
              });
            },
            onHorizontalDragUpdate: (details) {
              setState(() {
                cameraPos.x += details.delta.distance * (details.delta.direction - pi/2) / 100.0;
              }); 
            },
          ),
        );
    }
  }
}