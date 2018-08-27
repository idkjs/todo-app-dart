# todo_app

A new Flutter project.

## Database Class

Install deps from [package manager](https://pub.dartlang.org/packages/) [sqflite](https://pub.dartlang.org/packages/sqflite), [path_provider](https://pub.dartlang.org/packages/path_provider), [intl](https://pub.dartlang.org/packages/intl) by adding them to pubspec.yml

## Using Raw SQL

These methods are interchangeable and operate asynchronously.

```sql
db.rawQuery("SELECT * FROM yourTable" );

db.rawInsert('INSERT INTO yourTable(name, num)
    VALUES("some name", 1234)');

db.rawUpdate('UPDATE yourTable SET name = ?,
    WHERE name = ?', ["new name", "old name"]);

db.rawDelete('DELETE FROM yourTable WHERE id = 1');
```

## Using [SQFLite](https://pub.dartlang.org/packages/sqflite) Helpers

```dart
db.update('yourTable',
    yourObject.toMap(),
    where: "$colId = ?",
    whereArgs: [yourObject.id]);
```

## Adding to pubspec.yml

Go to `pubspec.yml` and list the dependencies. Use version 0.15.7 for intl

```yml
dependencies:
  flutter:
    sdk: flutter
  sqflite: any
  path_provider: any
  intl: ^0.15.7
```
