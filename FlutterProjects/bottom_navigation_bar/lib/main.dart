import 'package:flutter/material.dart';
import 'package:bottom_navigation_bar/pages/alarm.dart';
import 'package:bottom_navigation_bar/pages/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int currentPageIdx = 0;

  var pages = <Widget> [
    Home(),
    Alarm()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: pages[currentPageIdx],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.abc),
                label: 'Home'
              ),
            BottomNavigationBarItem(
                icon: Icon(Icons.access_alarms_rounded),
                label: 'ALAMR'
              ),
          ],
          onTap: (int idx) {
            setState(() {
              currentPageIdx = idx;
            });
          },
        ),
      ),
    );
  }
}