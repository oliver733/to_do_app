import 'package:flutter/material.dart';

class ToDoItem {
  final DateTime dateTime;
  final String title;
  final bool finished;

  ToDoItem(
      {@required this.dateTime, @required this.title, @required this.finished});
}
