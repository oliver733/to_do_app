import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:to_do_list/data/to_do_model.dart';
import 'package:to_do_list/data/to_do_repository.dart';
import './bloc.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final ToDoRepository _toDoRepository = ToDoRepository();

  @override
  ToDoState get initialState => InitialToDoState();

  @override
  Stream<ToDoState> mapEventToState(
    ToDoEvent event,
  ) async* {
    if (event is LoadTodos) {
      yield* _mapLoadTodosToState();
    } else if (event is AddTodo) {
      yield* _mapAddTodoToState(event);
    } else if (event is UpdateTodo) {
      yield* _mapUpdateTodoToState(event);
    } else if (event is DeleteTodo) {
      yield* _mapDeleteTodoToState(event);
    }
  }

  Stream<ToDoState> _mapLoadTodosToState() async* {
    try {
      final List<Todo> todos = await _toDoRepository.loadTodos();
      yield TodosLoaded(todos);
    } catch (_) {
      yield TodosNotLoaded();
    }
  }

  Stream<ToDoState> _mapAddTodoToState(AddTodo event) async* {
    if (state is TodosLoaded) {
      final List<Todo> updatedTodos = List.from((state as TodosLoaded).todos)
        ..add(event.todo);
      yield TodosLoaded(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<ToDoState> _mapUpdateTodoToState(UpdateTodo event) async* {
    if (state is TodosLoaded) {
      final List<Todo> updatedTodos = (state as TodosLoaded).todos.map((todo) {
        return todo.id == event.updatedTodo.id ? event.updatedTodo : todo;
      }).toList();
      yield TodosLoaded(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<ToDoState> _mapDeleteTodoToState(DeleteTodo event) async* {
    if (state is TodosLoaded) {
      final updatedTodos = (state as TodosLoaded)
          .todos
          .where((todo) => todo.id != event.todo.id)
          .toList();
      yield TodosLoaded(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Future _saveTodos(List<Todo> todos) {
    return _toDoRepository.saveTodos(todos: todos
        // todos.map((todo) => todo.toEntity()).toList(),
        );
  }
}