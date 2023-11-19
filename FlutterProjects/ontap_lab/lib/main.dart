import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: GestureThing()
        ),
      ),
    );
  }
}

class GestureThing extends StatelessWidget {
  const GestureThing({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => _showDialog(context),
        child: const Text("Hello world")
      )
    );
  }

  void _showDialog(BuildContext context) {
    showDialog( 
      context: context, builder: (BuildContext context) { 
         // return object of type Dialog
         return AlertDialog( 
            title: const Text("Hello!"), 
            content: const Text("Look behind you."),   
            actions: <Widget>[ 
                TextButton( 
                  child: new Text("Okay"),  
                  onPressed: () {   
                    Navigator.of(context).pop();  
                  }, 
               ), 
            ], 
        ); 
      }, 
    ); 
  }
}