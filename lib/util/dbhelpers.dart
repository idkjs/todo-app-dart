import 'package:sqflite/sqflite.dart';
import 'dart:async';
// following imports gets access to db directory
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/model/todo.dart';

// create class for db declaring our tables and columns, so String tblTodo = "todo" declars tbleTodo as string type and sets it todo which is the name or table. Same idea for columns.

// class DbHelper {
//   String tblTodo = "todo";
//   String colId = "id";
//   String coltitle = "title";
//   String colDescription = "description";
//   String colPriority = "priority";
//   String colDate = "date";
// }

// since we only want this class to be called once, so we need to turn it into a singleton. Singleton restricts the program to calling the class once only.
class DbHelper {
  // create DbHelperClass called dbHelper with an underscore to mark as private
  static final DbHelper _dbHelper = DbHelper._internal();
  String tblTodo = "todo";
  String colId = "id";
  String coltitle = "title";
  String colDescription = "description";
  String colPriority = "priority";
  String colDate = "date";
// named constructor
  DbHelper._internal();
// unnamed constructor returning _dbHelper
  factory DbHelper() {
    return _dbHelper;
  }
}
