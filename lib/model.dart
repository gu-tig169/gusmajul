import 'package:flutter/cupertino.dart';
import 'package:to_do_list/fetch.dart';

class Task {
  String id;
  String toDoMessage;
  bool completed = false;

  Task({this.id, this.toDoMessage, this.completed = false});

  static Map<String, dynamic> toJson(Task task) {
    return {
      'title': task.toDoMessage,
      'done': task.completed,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      toDoMessage: json['title'],
      completed: json['done'] == null ? false : json['done'],
    );
  }

  void checkboxValue() {
    completed = !completed;
  }
}

class MyState extends ChangeNotifier {

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  Future getTaskList() async {
    List<Task> tasks = await Fetch.getTasks();
    _tasks = tasks;
    notifyListeners();
  }

  void addItem(Task task) async {
    await Fetch.createTask(task);
    await getTaskList();
  }

  void removeItem(Task task) async {
    await Fetch.deleteTask(task.id);
    await getTaskList();
  }

  void getCheckboxValue(Task task) async {
    final taskIndex = _tasks.indexOf(task);
    _tasks[taskIndex].checkboxValue();
    await Fetch.updateTask(task.id, task.toDoMessage, task.completed);
    await getTaskList();
  }

  List<Task> filterOptions(String filter) {
    if (filter == 'Completed') {
      return  _tasks.where((task) => task.completed).toList();
    } else if (filter == 'Incompleted') {
      return _tasks.where((task) => !task.completed).toList();
    }
    return tasks;
  }
}
