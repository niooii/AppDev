// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> { 
    bool _ageSwitchValue = false; 
    String _youAre = "You are";
    String _compatible = "compatible with Dorris D. Developer";
    
    String _messageToUser = "TEST"; 
/// State
@override 
Widget build(BuildContext context) { 
     return Scaffold( 
          appBar: AppBar( 
              title: Text("Are you compatible with Doris?"), 
              ), 
             body: Padding( 
                   padding: const EdgeInsets.all(8.0), 
                      child: Column( 
                         children: [ _buildAgeSwitch(),              
                               _buildResultArea(), ],
        ), 
      ), 
    ); 
  } 

Widget _buildAgeSwitch() { 
     return Row( 
        children: <Widget> [
           Text("Are you 18 or older?"), 
           Switch( value: _ageSwitchValue, 
           onChanged: _updateAgeSwitch,
           ), 
         ],
       ); 
}

Widget _buildResultArea() {
  return Text(_messageToUser, textAlign: TextAlign.center);
 }
/// Actions

void _updateAgeSwitch(bool newValue) {
  setState(() {
     _ageSwitchValue = newValue;
     _messageToUser =
     _youAre+(_ageSwitchValue ? " " : " NOT ")+ _compatible;
  });
 }
}