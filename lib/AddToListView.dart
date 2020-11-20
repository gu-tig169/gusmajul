import 'package:flutter/material.dart';
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

  _AddToListViewState(task){
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
        title: Text("Add To Do's", 
        style: TextStyle(fontSize: 24)),
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

  Widget _userInput(){
    return Container(
      width: 300,
      child: TextField(
      controller: inputController,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: 'What are you going to do?',
        errorText: _validate ? 'You must write something to get shit done!' : null, 
        ), //En errortext visas om användaren ej skrivit något i Textfield
      ),
    );
  }

  Widget _addTask(){
    return FlatButton(
      onPressed: () {
        setState(() {
          if (inputController.text.isEmpty) {
            _validate = true;
          } //Om användaren trycker på knappen och TextField är tomt visas en errortext och ingen task skapas
            else if (inputController.text.isNotEmpty) {
            Navigator.pop(context, Task(toDoMessage: toDoMessage));
          } //Om TextField är ifyllt skapas en task
        }); 
      },
      color: Colors.purple[100],
      child: Text('+ ADD', style: TextStyle(fontSize: 16)),
    );
  }
} 