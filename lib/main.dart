import 'package:flutter/material.dart';
import 'ToDoListView.dart';
import 'model.dart';
import 'package:provider/provider.dart';

void main() {
  var state = MyState();

  runApp(
    ChangeNotifierProvider(
      create: (context) => state,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      home: ToDoListView(),
    );
  }
} //Min dropdown meny som ännu inte fyller någon funktion men som visar alternativ på hur man kan filtrera listan