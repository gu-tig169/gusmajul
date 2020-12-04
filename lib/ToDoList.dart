import 'package:flutter/material.dart';
import 'model.dart';
import 'package:provider/provider.dart';

class ToDoList extends StatelessWidget {
  final List<Task> tasks;

  ToDoList(this.tasks);

  Widget build(BuildContext context) {
    return ListView(
      children: tasks.map((task) => _listItem(context, task)).toList(),
    );
  }
}

Widget _listItem(context, Task task) {
  return Card(
    color: Colors.white24,
    child: Theme(
      data: ThemeData(unselectedWidgetColor: Colors.white),
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.orange[300],
        checkColor: Colors.black,
        title: Text(
          task.toDoMessage,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            decoration: (task.completed
                ? TextDecoration.lineThrough
                : TextDecoration.none),
          ),
        ),
        value: task.completed,
        onChanged: (bool completed) {
          Provider.of<MyState>(context, listen: false).getCheckboxValue(task);
        },
        secondary: IconButton(
          icon: Icon(Icons.clear),
          color: Colors.white,
          onPressed: () {
            Provider.of<MyState>(context, listen: false).removeItem(task);
          },
        ),
      ),
    ),
  );
}
