import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xff1e1e2e),
        appBar: AppBar(
          title: _Text("Your Profile",
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Color(0xffcdd6f4),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff181825),
        ),
        body: Center(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 550,
              width: double.infinity,
              color: Color(0xff6c7086),
              child: Stack(
                children: [
                  Container(
                    height: 190,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      color: Color(0xff45475a),
                      width: double.infinity,
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircleAvatar(
                          backgroundColor: Color(0xffeba0ac),
                          radius: 75,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 40,
                    top: 200,
                    child: _Text("Username",
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Color(0xffcdd6f4),
                    ),
                  ),
                  Positioned(
                    left: 40,
                    top: 270,
                    child: _Text("About me",
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color(0xffcdd6f4),
                    ),
                  ),
                  Positioned(
                    left: 40,
                    top: 310,
                    child: _Text("Hello world!!!!",
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Color(0xffcdd6f4),
                    ),
                  ),
                ],
              )
            )
          ),
        ),
      ),
    );
  }
}

class _Text extends StatelessWidget {

  String text;
  FontWeight? fontWeight = FontWeight.normal;
  double? fontSize = 10;
  Color? color = Colors.black;

  _Text(this.text, {
    super.key,
    this.fontWeight,
    this.fontSize,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color
      ),
    );
  }
}
