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
 
  Widget _listItem(context, task) {
    return Card(
          child: CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(task.toDoMessage, 
            style: TextStyle(
              decoration: (task.completed 
              ? TextDecoration.lineThrough 
              : TextDecoration.none),
            ),
          ),
          value: task.completed,
          onChanged: (bool checked) {
            Provider.of<MyState>(context, listen: false).changeCheckboxValue(task);
          }, //Ändrar värdet på checkbox
          secondary: IconButton(icon: Icon(Icons.clear),
          onPressed: () {
            var state = Provider.of<MyState>(context, listen: false);
            state.removeItem(task);
          }, //Tar bort en task om man trycker på clearknappen
        ),
      ),
    );  
  }  