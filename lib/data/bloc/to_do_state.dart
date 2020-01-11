import 'package:equatable/equatable.dart';
import 'package:to_do_list/data/models/all_todos_model.dart';
import 'package:to_do_list/data/models/todo_item_model.dart';

abstract class ToDoState extends Equatable {
  const ToDoState();
}

class InitialToDoState extends ToDoState {
  @override
  List<Object> get props => [];
}

class TodosLoaded extends ToDoState {
  final AllTodos allTodos;

  const TodosLoaded([this.allTodos]);

  @override
  List<Object> get props => [allTodos];

  @override
  String toString() => 'TodosLoaded { todos: $allTodos }';
}

class TodosNotLoaded extends ToDoState {
  @override
  List<Object> get props => [];
}
