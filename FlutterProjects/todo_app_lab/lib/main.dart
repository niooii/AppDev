import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app_lab/TodoEntry.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TodoList()
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  List<TodoEntry> entries = List.empty(growable: true);

  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescController = TextEditingController();

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a todo'),
          content: Column(
            children: <Widget>[
              TextField(
                controller: _taskNameController,
                decoration: const InputDecoration(hintText: 'Name of task'),
                autofocus: true,
              ),
              TextField(
                controller: _taskDescController,
                decoration: const InputDecoration(hintText: 'A brief description'),
                autofocus: true,
              ),
            ],
          ),
          actions: <Widget>[
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  entries.add(TodoEntry(_taskNameController.text, "yes"));
                });
                
                // clear controllers
                _taskNameController.clear();
                _taskDescController.clear();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo-stuff",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
      ),

      body: ListView(
        children: entries
          .map((e) {
            remove() {
              setState(() {
                entries.remove(e);
              });
            }
            return TodoEntryWidget(e, remove);
          }).toList()
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _displayDialog();
        },
        tooltip: "ADD STUFF",
        child: const Icon(Icons.add)
      ),
    );
  }
}

class TodoEntryWidget extends StatefulWidget {
  TodoEntryWidget(this.entry, this.onRemove, {super.key});

  TodoEntry entry;
  Function onRemove;

  @override
  State<TodoEntryWidget> createState() => _TodoEntryState();
}

class _TodoEntryState extends State<TodoEntryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          // width: double.infinity,
          // height: 20,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[200]!
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.entry.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  size: 24.0,
                ),
                onPressed: () {
                  widget.onRemove();
                },
              )
            ],
          )
        ),
        const Gap(20)
      ],
    );
  }
}