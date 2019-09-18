import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {

  final String taskToEdit;
  AddScreen({this.taskToEdit});

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController(text: widget.taskToEdit != null? widget.taskToEdit: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "Add To-Do",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orangeAccent,
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0)),
                margin: EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _messageController,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: "Gotta do my homework",
                      border: InputBorder.none),
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              InkWell(
                  onTap: () => Navigator.pop(
                      context, _messageController.text.toString()),
                  child: Text(
                    "SAVE",
                    style:
                        TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
