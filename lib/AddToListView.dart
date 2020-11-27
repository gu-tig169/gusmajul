import 'package:flutter/material.dart';
import 'Fetch.dart';
import 'package:to_do_list/model.dart';
import './model.dart';

class AddToListView extends StatefulWidget {
  final Task task;

  AddToListView(this.task);

  //Behövs konstruktor? 18:20 i filmen

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
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        centerTitle: true,
        title: Text("Add To Do's", style: TextStyle(fontSize: 24)),
      ),
      body: Center(
        child: Column(
          children: [
            Container(height: 30),
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
      width: 300,
      child: TextField(
        controller: inputController,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: 'What are you going to do?',
          errorText:
              _validate ? 'You must write something to get shit done!' : null,
        ),
      ),
    );
  }

  Widget _addTask() {
    return Column(
      children: [
        FlatButton(
          onPressed: () async {
            if (inputController.text.isEmpty) {
              setState(() {
                _validate = true;
              });
            }
            else if (inputController.text.isNotEmpty) {
              final task = await createTask(inputController.text, false);
              Navigator.pop(context, task);
            }
          },
          color: Colors.purple[100],
          child: Text('+ ADD', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
