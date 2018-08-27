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

// var that will contain the DB throughout the class. its a static Database type which we name _db
  static Database _db;

  // getter for _db
  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  // method of Future type that gets connection to db.
  // Future used to get potential value, here the db connection
  // async below imports from async package
  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "todos.db";
    var dbTodos = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbTodos;
  }

  // define _createDb method that launches an sql query to create the db.
  _createDb(Database db, int newVersion) async {
    await db.execute(
        // this the sql query, using $ means sql will concatinate what follows
        "CREATE TABLE $tblTodo($colId INTEGER PRIMARY KEY, $coltitle TEXT, " +
            "$colDescription TEXT, $colPriority INTEGER, $colDate TEXT)");
  }
}
