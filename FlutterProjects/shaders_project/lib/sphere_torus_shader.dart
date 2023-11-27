import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter_shaders/flutter_shaders.dart';

import 'package:shaders_project/vec3.dart';

class SphereTorusShader extends StatefulWidget {
  const SphereTorusShader({super.key});

  @override
  State<SphereTorusShader> createState() => _SphereTorusShaderState();
}

class _SphereTorusShaderState extends State<SphereTorusShader> {
  late Timer timer;
  double delta = 0;
  vec3 cameraPos = vec3(0.0, 0.0, -3.0);
  vec3 rot = vec3(0.0, 0.0, 0.0);
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
          painter: ShaderPainter(shader!, delta, cameraPos, rot),
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              setState(() {
                // updating deltatime has the
                // same effect as
                // speeding up/reversing rotation.
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

// this class is reloaded
// every time. is it efficient?
// not really. probably.
class ShaderPainter extends CustomPainter {
  final FragmentShader shader;
  final double time;
  final vec3 cameraPos;
  // rotation in pitch, yaw, roll.
  final vec3 rot;

  ShaderPainter(FragmentShader fragmentShader, this.time, this.cameraPos, this.rot)
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

