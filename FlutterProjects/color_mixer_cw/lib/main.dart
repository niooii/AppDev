import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen()
    );
  }
}

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  Color color1 = Colors.yellow;
  Color color2 = Colors.red;
  
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Color _averageColor(Color c1, Color c2) {
    var r = ((c1.red + c2.red)/2).round(); 
    var g = ((c1.green + c2.green)/2).round(); 
    var b = ((c1.blue + c2.blue)/2).round(); 
    var a = ((c1.alpha + c2.alpha)/2).round();

    return Color.fromARGB(a, r, g, b); 
  }

  setColor(int n, Color selection) {
    setState(() {
      if(n == 1) {
        widget.color1 = selection;
      }
      else 
      {
        widget.color2 = selection;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("COLOR GAME"),
        ),
        backgroundColor: Colors.amber
      ),
      body: Column(
        children: <Widget>[
          const Gap(20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ColorSelection(1, setColor),
              ColorSelection(2, setColor),
            ],
          ),
          const Gap(20.0),
          Container(
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: _averageColor(widget.color1, widget.color2),
            ),
          )
        ],
      ),
    );
  }
}

class ColorSelection extends StatefulWidget {
  int n;
  Function callback;
  ColorSelection(this.n, this.callback, {super.key});

  @override
  State<ColorSelection> createState() => _ColorSelectionState();
}

enum ColorLabel {
  red("Red", Colors.red),
  yellow("Yellow", Colors.yellow),
  blue("Blue", Colors.blue);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}

class _ColorSelectionState extends State<ColorSelection> {
  _ColorSelectionState();

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<ColorLabel>(
      initialSelection: ColorLabel.red,
      label: const Text("Color"),
      dropdownMenuEntries: ColorLabel.values
      .map<DropdownMenuEntry<ColorLabel>>((color) {
        return DropdownMenuEntry(
          value: color,
          label: color.label,
          enabled: true,
          style: MenuItemButton.styleFrom(
            foregroundColor: color.color,
          ),
        );
      }).toList(),
      onSelected: (selection) {
        widget.callback(widget.n, selection!.color);
      },
    );
  }
}