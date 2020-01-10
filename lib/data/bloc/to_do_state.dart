import 'package:equatable/equatable.dart';
import 'package:to_do_list/data/to_do_model.dart';

abstract class ToDoState extends Equatable {
  const ToDoState();
}

class InitialToDoState extends ToDoState {
  @override
  List<Object> get props => [];
}

class TodosLoaded extends ToDoState {
  final List<Todo> todos;

  const TodosLoaded([this.todos = const []]);

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodosLoaded { todos: $todos }';
}

class TodosNotLoaded extends ToDoState {
  @override
  List<Object> get props => [];
}
