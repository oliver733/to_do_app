import 'package:equatable/equatable.dart';
import 'package:to_do_list/data/models/todo_item_model.dart';

abstract class ToDoEvent extends Equatable {
  const ToDoEvent();
}

class LoadTodos extends ToDoEvent {
  @override
  List<Object> get props => [];
}

class AddTodo extends ToDoEvent {
  final Todo todo;

  const AddTodo(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'AddTodo { todo: $todo }';
}

class UpdateTodo extends ToDoEvent {
  final Todo updatedTodo;

  const UpdateTodo(this.updatedTodo);

  @override
  List<Object> get props => [updatedTodo];

  @override
  String toString() => 'UpdateTodo { updatedTodo: $updatedTodo }';
}

class DeleteTodo extends ToDoEvent {
  final Todo todo;

  const DeleteTodo(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'DeleteTodo { todo: $todo }';
}
