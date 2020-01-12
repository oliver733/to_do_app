import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

enum DateType { onDay, dueDay }

class Todo extends Equatable {
  final bool complete;
  final String id;
  final DateTime dateTime;
  final DateType dateType;
  final String task;

  Todo(
    this.task, {
    this.complete = false,
    this.dateTime,
    this.dateType = DateType.onDay,
    String id,
  }) : this.id = id ?? Uuid().v4();

  Todo copyWith({
    bool complete,
    String id,
    String task,
    DateTime dateTime,
    DateType dateType,
  }) {
    return Todo(
      task ?? this.task,
      complete: complete ?? this.complete,
      dateTime: dateTime ?? this.dateTime,
      dateType: dateType ?? this.dateType,
      id: id ?? this.id,
    );
  }

  Todo.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        complete = (map['complete'] == 1),
        dateTime = map['dateTime'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['dateTime'])
            : null,
        dateType =
            map['dateType'] == 'dueDay' ? DateType.dueDay : DateType.onDay,
        task = map['task'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task': task,
      'complete': complete ? 1 : 0,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'dateType': (dateType == DateType.dueDay ? 'dueDay' : 'onDay'),
    };
  }

  @override
  List<Object> get props => [complete, id, task];

  @override
  String toString() {
    return 'Todo { complete: $complete, task: $task, id: $id }';
  }
}
