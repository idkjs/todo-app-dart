import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/util/dbhelpers.dart';
import 'package:intl/intl.dart';

class TodoDetail extends StatefulWidget {
  // If you never intend to change a variable, use final or const, either instead of var or in addition to a type.
  // see: https://www.dartlang.org/guides/language/language-tour#final-and-const
  final Todo todo;
  TodoDetail(this.todo);

  @override
  State<StatefulWidget> createState() => TodoDetailState();
}

class TodoDetailState extends State {
  Todo todo;
  final _priorities = ["High", "Medium", "Low"];
  String _priority = "Low";

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // if the todo contains a title or descr, we want to show it
    titleController.text = todo.title;
    descriptionController.text = todo.description;
    // set TextStyle
    TextStyle textStyle = Theme.of(context).textTheme.title;
    // return the UI
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(todo.title),
        ),
        body: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              style: textStyle,
              decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
            TextField(
              controller: descriptionController,
              style: textStyle,
              decoration: InputDecoration(
                  labelText: "Description",
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
            DropdownButton<String>(
              items: _priorities.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              style: textStyle,
              value: "Low",
              onChanged: null,
            )
          ],
        ));
  }
}
