import 'package:flutter/material.dart';
import 'package:simple_note_app/themes/Palettes.dart';
import 'package:simple_note_app/data/note.dart';

class NoteDisplay extends StatefulWidget {
  NoteDisplay(this.note, {super.key});

  Note note;

  @override
  State<NoteDisplay> createState() => NoteDisplayState();
}

class NoteDisplayState extends State<NoteDisplay> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Container(
        width: 200.0,
        // height: isExpanded ? 200.0 : 100.0,
        decoration: BoxDecoration(
          color: Mocha.surface0,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                    widget.note.title,
                      style: const TextStyle(
                        color: Mocha.text,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                    "${widget.note.dateCreated.month}/${widget.note.dateCreated.day}/${widget.note.dateCreated.year}",
                      style: const TextStyle(
                        color: Mocha.lavender,
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Text(
                  widget.note.content,
                  style: TextStyle(color: Mocha.text, fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
