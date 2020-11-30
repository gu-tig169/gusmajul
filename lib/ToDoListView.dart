import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AddToListView.dart';
import 'ToDoList.dart';
import 'model.dart';

class ToDoListView extends StatefulWidget {
  @override
  _ToDoListViewState createState() => _ToDoListViewState();
}

class _ToDoListViewState extends State<ToDoListView> {
  List<String> filterBy = ['All Tasks', 'Completed', 'Incompleted'];
  String filterValue = 'All Tasks';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        centerTitle: true,
        title: Text('To Do List', style: TextStyle(fontSize: 24)),
        actions: [
          _dropDownButton(),
        ],
      ),
      body: Consumer<MyState>(
        builder: (context, state, child) =>
            ToDoList(state.filterOptions(filterValue)),
      ),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _dropDownButton() {
    return DropdownButton(
      onChanged: (newValue) {
        setState(() {
          filterValue = newValue;
        });
      },
      items: filterBy.map((filter) {
        return DropdownMenuItem<String>(
          value: filter,
          child: Text(filter),
        );
      }).toList(),
      icon: Icon(Icons.more_vert, size: 25, color: Colors.white),
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.purple[200],
      onPressed: () async {
        var newTask = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddToListView(Task(
                      toDoMessage: 'Task',
                    ))));
        if (newTask != null) {
          Provider.of<MyState>(context, listen: false).addItem(newTask);
        }
      },
    );
  }
}
