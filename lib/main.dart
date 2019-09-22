import 'package:flutter/material.dart';
import 'package:to_do_app/ui/home_page.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do',
      home: TodoList(),
    );
  }
}
