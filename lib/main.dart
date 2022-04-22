import 'package:flutter/material.dart';
import 'package:todo_app/screens/todo_list.dart';

void main() {
  runApp(const Todo());
}

class Todo extends StatelessWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TodoList());
  }
}

