import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Todo extends Equatable {
  final bool complete;
  final String id;
  final DateTime dateTime;
  final String task;

  Todo(
    this.task, {
    this.complete = false,
    this.dateTime,
    String id,
  }) : this.id = id ?? Uuid().v4();

  Todo copyWith({bool complete, String id, String task}) {
    // datetime TODO:
    return Todo(
      task ?? this.task,
      complete: complete ?? this.complete,
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
