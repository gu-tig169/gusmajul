import 'package:flutter/cupertino.dart';

class Task {
  String toDoMessage;
  bool completed;

  Task({this.toDoMessage, this.completed = false});

  void checkboxValue() {
    completed = !completed;
  } //Checkbox: ikryssad eller ej
}

class MyState extends ChangeNotifier{

  final List<Task> _tasks = [];

  void addItem(Task task){
    _tasks.add(task);
    notifyListeners();
  } //Lägg till task

  void removeItem(Task task){
    _tasks.remove(task);
    notifyListeners();
  } //Ta bort task

  void getCheckboxValue(Task task){
    final taskIndex = _tasks.indexOf(task);
    _tasks[taskIndex].checkboxValue();
    notifyListeners();
  } //Om checkboxen blir tryckt på anropas checkboxValue() och värdet ändras

  List<Task> filterOptions(String filter){
    if (filter == 'Completed') {
      return _tasks.where((task) => task.completed).toList();
    } else if (filter == 'Incompleted') {
      return _tasks.where((task) => !task.completed).toList();
    }
    return _tasks;
  } //Om filtreringen är 'Completed' visas bara de tasks som har värdet completed
} //Om filtreringen är 'Incompleted' visas bara de tasks som inte har värdet completed
//Annars returneras hela listan (då filteringen är 'All Tasks')