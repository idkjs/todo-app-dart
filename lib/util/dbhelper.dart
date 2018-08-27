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
  String colTitle = "title";
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

// sql CRUD queries
  Future<int> insertTodo(Todo todo) async {
    Database db = await this.db;
    var result = await db.insert(tblTodo, todo.toMap());
    return result;
  }

  Future<List> getTodos() async {
    Database db = await this.db;
    var result =
        await db.rawQuery("SELECT * FROM $tblTodo order by $colPriority ASC");
    return result;
  }

// example of using sqflite helper
  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite
        .firstIntValue(await db.rawQuery("select count (*) from $tblTodo"));
    return result;
  }

  Future<int> updateTodo(Todo todo) async {
    var db = await this.db;
    var result = await db.update(tblTodo, todo.toMap(),
        where: "$colId = ?", whereArgs: [todo.id]);
    return result;
  }

  Future<int> deleteTodo(int id) async {
    int result;
    var db = await this.db;
    result = await db.rawDelete('DELETE FROM $tblTodo WHERE $colId = $id');
    return result;
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
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        // this the sql query, using $ means sql will concatinate what follows
        "CREATE TABLE $tblTodo($colId INTEGER PRIMARY KEY, $colTitle TEXT, " +
            "$colDescription TEXT, $colPriority INTEGER, $colDate TEXT)");
  }
}
