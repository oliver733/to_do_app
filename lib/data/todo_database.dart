import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/todo_item_model.dart';

class TodoDatabase {
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  Future<Database> createDatabase() async {
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE todo_table(id TEXT PRIMARY KEY, task TEXT, complete INTEGER, dateTime INTEGER, dateType TEXT)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    return database;
  }

  Future<void> insertTodo({
    @required Todo todo,
  }) async {
    final Database db = await database;

    await db.insert(
      'todo_table',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Todo>> todos() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todo_table');
    return List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]);
    });
  }

  Future<void> updateTodo({
    @required Todo todo,
  }) async {
    final db = await database;
    await db.update(
      'todo_table',
      todo.toMap(),
      where: "id = ?",
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteTodo({
    @required String id,
  }) async {
    final db = await database;
    await db.delete(
      'todo_table',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
