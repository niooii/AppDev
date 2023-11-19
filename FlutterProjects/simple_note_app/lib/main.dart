import 'package:flutter/material.dart';
import 'package:simple_note_app/themes/Palettes.dart';
import 'package:simple_note_app/widgets/note_display.dart';
import 'package:simple_note_app/data/note.dart';

// actually trying to write good code this time. :D

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage()
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({super.key});

  List<Note> notes = List.empty(growable: true);

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notes",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30.0, color: Mocha.text),
        ),
        centerTitle: true,
        backgroundColor: Mocha.crust,
        // for gradient asthetics
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Mocha.crust, Mocha.base])),
        ),
      ),
      body: ListView(
        children: widget.notes
        .map((note) {
          return NoteDisplay(note);
        })
        .toList()
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          widget.notes.add(PersonalNote("Untitled",
              "foo bar baz foo bar baz foo bar baz foo bar baz foo bar baz"));
        }),
        backgroundColor: Mocha.overlay2,
        child: const Icon(Icons.add),
      ),
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      backgroundColor: Mocha.base,
    );
  }
}