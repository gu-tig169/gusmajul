import 'package:flutter/cupertino.dart';
import 'package:to_do_list/fetch.dart';


class Task {
  String id;
  String toDoMessage;
  bool completed;

  Task({this.id, this.toDoMessage, this.completed = false});

  void checkboxValue() {
    completed = !completed;
  }
  factory Task.fromJson(Map<String, dynamic>json) {
    return Task(
      id: json['id'],
      toDoMessage: json['title'],
      completed: json['done'],
    );
  }
}

class MyState extends ChangeNotifier{

  final List<Task> _tasks = [];

  void addItem(Task task){
    _tasks.add(task);
    notifyListeners();
  }

  void removeItem(Task task){
    _tasks.remove(task);
    notifyListeners();
  }

  void getCheckboxValue(Task task){
    final taskIndex = _tasks.indexOf(task);
    _tasks[taskIndex].checkboxValue();
    notifyListeners();
  }

  List<Task> filterOptions(String filter){
    if (filter == 'Completed') {
      return _tasks.where((task) => task.completed).toList();
    } else if (filter == 'Incompleted') {
      return _tasks.where((task) => !task.completed).toList();
    }
    return _tasks;
  }
}