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

  @override
  List<Object> get props => [complete, id, task];

  @override
  String toString() {
    return 'Todo { complete: $complete, task: $task, id: $id }';
  }

  // TodoEntity toEntity() {
  //   return TodoEntity(task, id, note, complete);
  // }

  // static Todo fromEntity(TodoEntity entity) {
  //   return Todo(
  //     entity.task,
  //     complete: entity.complete ?? false,
  //     note: entity.note,
  //     id: entity.id ?? Uuid().generateV4(),
  //   );
  // }
}
