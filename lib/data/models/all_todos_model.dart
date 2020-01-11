import 'package:flutter/material.dart';
import 'package:to_do_list/data/models/todo_item_model.dart';

class AllTodos {
  List<Todo> todos;
  Map<DateTime, List<Todo>> calenderMap;

  AllTodos({@required this.todos, @required this.calenderMap});
}
