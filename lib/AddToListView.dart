import 'package:flutter/material.dart';
import 'package:to_do_list/model.dart';
import './model.dart';

class AddToListView extends StatefulWidget {
  final Task task;

  AddToListView(this.task);

  @override
  _AddToListViewState createState() => _AddToListViewState(task);
}

class _AddToListViewState extends State<AddToListView> {
  String toDoMessage;
  TextEditingController inputController = TextEditingController();
  bool _validate = false;
  Future<List<Task>> futureTasks;
  bool done = false;

  _AddToListViewState(task) {
    this.toDoMessage = task.toDoMessage;
    inputController.addListener(() {
      setState(() {
        toDoMessage = inputController.text;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Add To Do's", style: TextStyle(fontSize: 24)),
      ),
      body: Center(
        child: Column(
          children: [
            Container(height: 150),
            _userInput(),
            Container(height: 30),
            _addTask(),
          ],
        ),
      ),
    );
  }

  Widget _userInput() {
    return Container(
      width: 360,
      decoration: boxDecoration(),
      child: TextField(
        style: TextStyle(color: Colors.white),
        controller: inputController,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'What are you going to do?',
          hintStyle: TextStyle(color: Colors.white54),
          errorText:
              _validate ? 'You must write something to get shit done!' : null,
        ),
      ),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: Colors.orange[300],
        width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(15)),
    );
  }

  Widget _addTask() {
    return Column(
      children: [
        FlatButton(
          minWidth: 150,
          onPressed: () async {
            if (inputController.text.isEmpty) {
              setState(() {
                _validate = true;
              });
            } else if (inputController.text.isNotEmpty) {
              Navigator.pop(
                  context, Task(toDoMessage: toDoMessage, completed: false));
            }
          },
          color: Colors.orange[300],
          child: Text('+ ADD', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
