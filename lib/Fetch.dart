import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model.dart';

const API_URL = 'https://todoapp-api-vldfm.ondigitalocean.app';
const API_KEY = 'c7551588-e568-4868-b74c-712e5389af55';

Future<Task> createTask(String title, bool done) async {
  final http.Response response = await http.post(
    '$API_URL/todos?key=$API_KEY',
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'title': title,
      'done': done,
    }),
  );
  if (response.statusCode == 200) {
    final addedTask = jsonDecode(response.body).last;
    return Task.fromJson(addedTask);
  } else {
    throw Exception(response.statusCode.toString());
  }
}

Future<List<Task>> fetchTasks() async {
  final http.Response response = await http.get('$API_URL/todos?key=$API_KEY');
  if (response.statusCode == 200) {
    String bodyString = response.body;
    var json = jsonDecode(bodyString);
    return json.map<Task>((data) {
      return Task.fromJson(data);
    }).toList();
  } else {
    throw Exception(response.statusCode.toString());
  }
}

Future updateTask(String id, String title, bool done) async {
  final http.Response response =
      await http.put('$API_URL/todos/$id?key=$API_KEY',
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, dynamic>{
            'title': title,
            'done': done,
          }));
  if (response.statusCode != 200) {
    throw Exception(response.statusCode.toString());
  }
}

Future deleteTask(String id) async {
  final http.Response response =
      await http.delete('$API_URL/todos/$id?key=$API_KEY');
  if (response.statusCode != 200) {
    throw Exception(response.statusCode.toString());
  }
}
