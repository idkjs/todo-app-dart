import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/util/dbhelper.dart';
import 'package:intl/intl.dart';

// create local instance of DbHelper
DbHelper helper = DbHelper();
// create [] of "" with names we want in menu button
final List<String> choices = const <String>[
  'Save Todo & Back',
  'Delete Todo',
  'Back to List'
];

// create identifiers for each string
const mnuSave = 'Save Todo & Back';
const mnuDelete = 'Delete Todo';
const mnuBack = 'Back to List';

// If you never intend to change a variable, use final or const, either instead of var or in addition to a type.
// see: https://www.dartlang.org/guides/language/language-tour#final-and-const
class TodoDetail extends StatefulWidget {
  final Todo todo;
  TodoDetail(this.todo);

  @override
  State<StatefulWidget> createState() => TodoDetailState(todo);
}

class TodoDetailState extends State {
  Todo todo;
  TodoDetailState(this.todo);

  final _priorities = ["High", "Medium", "Low"];
  String _priority = "Low";

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // if the todo contains a t;itle or descr, we want to show it
    titleController.text = todo.title;
    descriptionController.text = todo.description;
    // set TextStyle
    TextStyle textStyle = Theme.of(context).textTheme.title;
    // return the UI using [scaffold](https://docs.flutter.io/flutter/material/Scaffold-class.html)
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(todo.title),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: select,
            itemBuilder: (BuildContext context) {
              return choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                TextField(
                  controller: titleController,
                  style: textStyle,
                  onChanged: (value) => this.updateTitle(),
                  decoration: InputDecoration(
                    labelText: "Title",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: TextField(
                      controller: descriptionController,
                      style: textStyle,
                      onChanged: (value) => this.updateDescription(),
                      decoration: InputDecoration(
                        labelText: "Description",
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    )),
                ListTile(
                    title: DropdownButton<String>(
                  items: _priorities.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  style: textStyle,
                  value: retrievePriority(todo.priority),
                  onChanged: (value) => updatePriority(value),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }

// check which menu item was selected by user
  void select(String value) async {
    int result;
    switch (value) {
      case mnuSave:
        save();
        break;
      case mnuDelete:
        // call route change on mnudelete
        Navigator.pop(context, true);
        if (todo.id == null) {
          return;
        }
        result = await helper.deleteTodo(todo.id);
        // create some user feedback
        if (result != 0) {
          AlertDialog alertDialog = AlertDialog(
            title: Text("Delete Todo"),
            content: Text("The Todo has been deleted"),
          );
          showDialog(context: context, builder: (_) => alertDialog);
        }
        break;
      // back mnu with navigation
      case mnuBack:
        Navigator.pop(context, true);
        break;
      default:
    }
  }

  void save() {
    todo.date = new DateFormat.yMd().format(DateTime.now());
    // check if id is not null, meaning checking if its a new todo, if not, update the todo by id
    if (todo.id != null) {
      helper.updateTodo(todo);
    } else {
      // if you null, have a new one
      helper.insertTodo(todo);
    }
    // then nav to list screen
    Navigator.pop(context, true);
  }

  // helper to update the priority of a todo
  void updatePriority(String value) {
    switch (value) {
      case "High":
        todo.priority = 1;
        break;
      case "Medium":
        todo.priority = 2;
        break;
      case "Low":
        todo.priority = 3;
        break;
    }
    // set state on _priority with the value
    setState(() {
      _priority = value;
    });
  }

  // method to convert priority value int to string
  // takes the integer of the priority as a parameter and returns the item in priorites array at the position of the passed int - 1 for zero index
  String retrievePriority(int value) {
    return _priorities[value - 1];
  }

  // two methods to update stuff
  // update title by taking the value from titleController.text
  void updateTitle() {
    todo.title = titleController.text;
  }

  void updateDescription() {
    todo.description = descriptionController.text;
  }
}

//         body: Padding(
// padding: EdgeInsets.only(top:35.0, left: 10.0, right:10.0),
// child:Column(
// children: <Widget>[
//   TextField(
//     controller: titleController,
//     style: textStyle,
//     decoration: InputDecoration(
//         labelText: "Title",
//         labelStyle: textStyle,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(5.0),
//         ),
//         ),
//   ),
// Padding(
//   padding: EdgeInsets.only(top:15.0, bottom: 15.0),
//   child:TextField(
//   controller: descriptionController,
//   style: textStyle,
//   decoration: InputDecoration(
//       labelText: "Description",
//       labelStyle: textStyle,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(5.0),
//       ),
//       ),
// )),
