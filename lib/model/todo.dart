// file for Model class. Put properties, methods and constructors for todo Object
// no import statement, not importing anything yet.Object
class Todo {
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;
// this is the default constructor, or the constructor, for the Todo object.
  Todo(this._title, this._priority, this._date, [this._description]);
  Todo.withId(this._title, this._priority, this._date, [this._description]);
  // This is a GETTER. It gets the id and returns the private class _id from the object. Same for rest of them
  int get id => _id;
  String get title => _title;
  String get description => _description;
  int get priority => _priority;
  String get date => _date;

  // SETTER. Dont need one for id b/c it will never change. Setters define the property in the object, you can put constraints/checks on them
  set title(String newTitle) {
    if (newTitle.length <= 255) {
      _title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      _description = newDescription;
    }
  }

  set priority(int newPriority) {
    if (newPriority >= 0 && newPriority <= 3) {
      _priority = newPriority;
    }
  }

  set date(String newDate) => newDate;

  // 2 more useful methods for Todo class. Map and ...
  // Map is a string of key, value pairs from which you return a value using its associated key, like in sql. Maps can be iterated. Can use string as key. We will use it to turn a todo object into a map.
  Map<String, dynamic> toMap() {
    // create a var map set to Map type and define the keys
    var map = Map<String, dynamic>();
    map["title"] = _title;
    map["description"] = _description;
    map["priority"] = _priority;
    map["date"] = _date;

    // if statement to only map the id if its not null since a new object, when we create one from ui, wont yet have an id
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  // method which is a named constructor, does opposite of Map method. Takes in an object and creates a Todo type object out of it.
  Todo.fromObject(dynamic o) {
    this._id = o["id"];
    this._title = o["title"];
    this._description = o["description"];
    this._priority = o["priority"];
    this._date = o["date"];
  }
}
