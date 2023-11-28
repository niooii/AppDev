import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';

import 'package:shaders_project/vec3.dart';

class SphereInfiniteShader extends StatefulWidget {
  const SphereInfiniteShader({super.key});

  @override
  State<SphereInfiniteShader> createState() => _SphereInfiniteShaderState();
}

class _SphereInfiniteShaderState extends State<SphereInfiniteShader> {
  late Timer timer;
  double delta = 0;
  vec3 cameraPos = vec3(0.0, 0.0, -3.0);
  vec3 rot = vec3(0.0, 0.0, 0.0);
  vec3 travel_dir = vec3(0.0, 0.0, 0.01);
  double movespeed = 0.01;
  FragmentShader? shader;

  void loadShader() async {
    var program = await FragmentProgram.fromAsset('shaders/sphere_infinite.frag');
    shader = program.fragmentShader();
    setState(() {
      // triggers repaint
    });

    timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        delta += 1 / 60;
        cameraPos += travel_dir;
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
            // onLongPressMoveUpdate: (_) {
            //   setState(() {
            //     movespeed += 0.01;
            //   });*
            // },
            onPanUpdate: (details) {
              rot.z += details.delta.dy/400;
              rot.y += -details.delta.dx/400;

              // wrap around values so
              // app doesnt crash

              if(rot.z > pi) {
                rot.z -= pi * 2;
              }
              if(rot.z < -pi) {
                rot.z += pi * 2;
              }

              if(rot.y > pi) {
                rot.y -= pi * 2;
              }
              if(rot.y < -pi) {
                rot.y += pi * 2;
              }

              // update travel direction
              travel_dir = vec3(0.0, 0.0, 0.01).rotate(vec3(rot.z, 
              rot.y, 
              rot.x));

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
    // camerapos
    shader.setFloat(3, cameraPos.x);
    shader.setFloat(4, cameraPos.y);
    shader.setFloat(5, cameraPos.z);

    // camera rotation
    shader.setFloat(6, rot.x);
    shader.setFloat(7, rot.y);
    shader.setFloat(8, rot.z);
    paint.shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

