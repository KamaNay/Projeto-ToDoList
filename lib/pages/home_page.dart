import 'package:flutter/material.dart';
import 'package:flutter_1/data/database.dart';
import 'package:flutter_1/utilities/dialog_box.dart';
import 'package:flutter_1/utilities/todo_tile.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // first time ever open the app, then create a default data
    super.initState();
    // Check if there is initial data, if not, create it
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exits data
      db.loadData();
    }
  }

  // text controller
  final _controller = TextEditingController();
  // list to dodo tasks

  // Checkbox callback
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // Limit the length of the task
  String lengthLimit(String task) {
    if (task.length <= 29) {
      return task;
    } else {
      return '${task.substring(0, 25)}...';
    }
  }

  // creating new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  // Open task details
  void openTask(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tarefa'),
          content: Text(db.toDoList[index][0]),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.close, color: Color.fromARGB(255, 6, 17, 79)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 159, 175, 202),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 6, 17, 79),
        title: const Text(
          'TO DO',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: const Color.fromARGB(255, 6, 17, 79),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            onPressed: () => openTask(index),
            taskName: lengthLimit(db.toDoList[index][0]),
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
