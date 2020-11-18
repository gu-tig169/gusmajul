import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.purple[200],
      centerTitle: true,
      title: Text('To Do List', style: TextStyle(fontSize: 24)),
      actions: [
        _filterOptions(),
      ],
    ),
      body: _toDoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.push( 
        context,
        MaterialPageRoute(builder: (context) => AddToList())
        );
        }, //Knappen för att komma till vyn där man kan lägga till saker i listan
        child: Icon(Icons.add),
        backgroundColor: Colors.purple[200],
      ),
    );
  }
}

  Widget _filterOptions() {
    return PopupMenuButton<String>(
      itemBuilder: (context) => [ //itemBuilder körs när menyknappen trycks på
        PopupMenuItem(child:
        Text('all'),),
        PopupMenuItem(child:
        Text('done'),),
        PopupMenuItem(child:
        Text('undone'),),
      ], //De items man ska kunna filtrera på
      icon: Icon(Icons.more_vert,
      size: 25,
      color: Colors.white
      ),
    );
  } //Min popup meny som ännu inte fyller någon funktion men som visar alternativ på hur man kan filtrera listan

  Widget _toDoList() {
    var toDo = [
      'Brush my teeth',
      'Build an app',
      'Take a nap',
      'Eat pizza',
      'Take a walk',
      'Go to Systembolaget',
      'Drink Wine',
      'Take another nap',
      'Drink Water',
      'Take a walk',
      'Eat candy',
  ]; 
  //En lista med mina to do's

    return ListView(
      children: toDo.map((item) => _item(item)).toList(),
    );
    //ListView returnerar en skrollbar lista av min toDo
    //map() skickar in varje element i vår lista till metoden _item()
    //toList() samlar alla items från _item() i en lista
  }

  Widget _item(text) {
    return Card(
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading, //Lägger checkboxen först
        title: Text(text),
        value: false,
        onChanged: (val) {},
        secondary: IconButton(icon: Icon(Icons.clear), //En knapp för att ta bort det i listan
        onPressed: () {},
        ),
      ),
    );  
  } 
  //En stateless CheckboxListTile som skapar en lista kombinerat med en checkbox
  //La den i Card för att "dela in" listan, blev snyggare tycker jag

  class AddToList extends StatelessWidget {
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[200],
          centerTitle: true,
          title: Text('To Do List', 
          style: TextStyle(fontSize: 24)),
        ),
        body: Center(
          child: Column(
            children: [
            Container(height: 30),
            _inputField(),
            Container(height: 30),
            _addToList(),
            ],
          ),
        ),
      );
    }
  } 
  //Vyn för att lägga till saker i listan

  Widget _inputField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey, 
          width: 2)
          ),
      margin: EdgeInsets.only(left: 30, top: 20, right: 30),
      child: TextField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: 'What are you going to do?',
          border: InputBorder.none),
      ),
    );
  } 
  //En container med ett textfält där man kan skriva in det man vill lägga till i listan

   Widget _addToList() {
    return FlatButton(
        onPressed: () {},
        color: Colors.purple[100],
        child:
          Text('+ ADD', style: TextStyle(fontSize: 16)),
     );
  }
  //En "platt" knapp med text