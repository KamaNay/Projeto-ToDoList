import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  // reference the box
  final _myBox = Hive.box('mybox');

  // run this if it is the first time ever opening app
  void createInitialData() {
    toDoList = [
      ["Insira novas tarefas no botao abaixo", false],
      ["Arraste para esquerda para deletar", false],
    ];
  }

  // load the data from the database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  // update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
