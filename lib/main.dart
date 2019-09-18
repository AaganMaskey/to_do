import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:to_do_app/add_screen.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'To-Do', debugShowCheckedModeBanner: false, home: TodoList());
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  List _colorList = [];
  var _random;

  @override
  void initState() {
    super.initState();
    _colorList = [Color(0xffFFB507), Color(0xff1FCDBD), Color(0xffEB648B)];
    _random = Random();
  }

  void _addTodoItem(String toDo) {
    if (toDo.length > 0) {
      setState(() {
        _todoItems.add(toDo);
      });
    }
  }
  
  Future addToDo() async {
    String newToDO = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddScreen()));
    _addTodoItem(newToDO);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Todo List',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              onPressed: () => addToDo(),
              tooltip: 'Add task',
              icon: Icon(
                Icons.add,
                color: Colors.black,
                size: 32.0,
              )),
        ],
      ),
      body: _todoItems.length > 0
          ? ListView.builder(
              itemCount: _todoItems.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onHorizontalDragStart: (_) => markAsDone(index),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: _colorList[_random.nextInt(_colorList.length)],
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: ListTile(
                      onTap: () => editTask(index),
                      onLongPress: () => markAsDone(index),
                      title: Text(_todoItems[index], style: TextStyle(color: Colors.white, fontSize: 18.0),),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text("Aich!!! Nothing to do"),
            ),
    );
  }

  void editTask(int index) async{
    String editedToDo = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddScreen(taskToEdit: _todoItems[index],)));
    _todoItems[index] = editedToDo != null ? editedToDo : _todoItems[index];
  }

  void markAsDone(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Mark as done???"),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  color: Colors.white,
                  child: Text("Cancel"),
                  onPressed: () => Navigator.pop(context),
                ),
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () {
                    setState(() {
                      _todoItems.removeAt(index);
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
          );
        });
  }
}
