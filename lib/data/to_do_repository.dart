import 'package:flutter/material.dart';
import 'package:to_do_list/data/models/todo_item_model.dart';

class ToDoRepository {
  Future<List<Todo>> loadTodos() async {
    List<Todo> todos = [
      Todo("Task.. ", complete: false, dateTime: DateTime.now())
    ]; //TODO: get todos from sql..
    return todos;
  }

  Future<void> saveTodos({
    @required List<Todo> todos,
  }) async {} //TODO Save to db
}
