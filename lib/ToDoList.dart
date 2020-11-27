import 'package:flutter/material.dart';
import 'Fetch.dart';
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
    color: Colors.purple[50],
    child: CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.purple[200],
      title: Text(
        task.toDoMessage,
        style: TextStyle(
          decoration: (task.completed
              ? TextDecoration.lineThrough
              : TextDecoration.none),
        ),
      ),
      value: task.completed,
      onChanged: (bool checked) async {
        await updateTask(task.id, task.toDoMessage, checked);
        Provider.of<MyState>(context, listen: false)
            .getCheckboxValue(task);
      },
      secondary: IconButton(
        icon: Icon(Icons.clear),
        onPressed: () async {
          await deleteTask(task.id);
          var state = Provider.of<MyState>(context, listen: false);
          state.removeItem(task);
        },
      ),
    ),
  );
}