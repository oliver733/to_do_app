import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/data/models/all_todos_model.dart';
import 'package:to_do_list/data/models/todo_item_model.dart';
import 'package:to_do_list/data/to_do_repository.dart';
import './bloc.dart';

class TodoBloc extends Bloc<ToDoEvent, ToDoState> {
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
      List<Todo> todos = await _toDoRepository.loadTodos();
      Map<DateTime, List<Todo>> calenderMap =
          _updateEventsDateMap(todos: todos);
      yield TodosLoaded(AllTodos(todos: todos, calenderMap: calenderMap));
    } catch (_) {
      yield TodosNotLoaded();
    }
  }

  Stream<ToDoState> _mapAddTodoToState(AddTodo event) async* {
    if (state is TodosLoaded) {
      List<Todo> updatedTodos = (state as TodosLoaded).allTodos.todos
        ..add(event.todo);
      Map<DateTime, List<Todo>> updatedCalenderMap =
          _updateEventsDateMap(todos: updatedTodos);

      yield TodosLoaded(
          AllTodos(todos: updatedTodos, calenderMap: updatedCalenderMap));
      _saveTodos(updatedTodos);
    }
  }

  Stream<ToDoState> _mapUpdateTodoToState(UpdateTodo event) async* {
    if (state is TodosLoaded) {
      List<Todo> updatedTodos =
          (state as TodosLoaded).allTodos.todos.map((todo) {
        return todo.id == event.updatedTodo.id ? event.updatedTodo : todo;
      }).toList();
      print(updatedTodos.length);
      Map<DateTime, List<Todo>> updatedCalenderMap =
          _updateEventsDateMap(todos: updatedTodos);
      print(updatedCalenderMap.keys.length);
      yield TodosLoaded(
          AllTodos(todos: updatedTodos, calenderMap: updatedCalenderMap));
      _saveTodos(updatedTodos);
    }
  }

  Stream<ToDoState> _mapDeleteTodoToState(DeleteTodo event) async* {
    if (state is TodosLoaded) {
      List<Todo> updatedTodos = (state as TodosLoaded)
          .allTodos
          .todos
          .where((todo) => todo.id != event.todo.id)
          .toList();
      Map<DateTime, List<Todo>> updatedCalenderMap =
          _updateEventsDateMap(todos: updatedTodos);
      yield TodosLoaded(
          AllTodos(todos: updatedTodos, calenderMap: updatedCalenderMap));
      _saveTodos(updatedTodos);
    }
  }

  Future _saveTodos(List<Todo> todos) {
    return _toDoRepository.saveTodos(todos: todos
        // todos.map((todo) => todo.toEntity()).toList(),
        );
  }

  Map<DateTime, List<Todo>> _updateEventsDateMap({@required List<Todo> todos}) {
    Map<DateTime, List<Todo>> timeTodosMap = {};
    for (Todo todo in todos) {
      if (todo.dateTime != null) {
        DateTime roundedDateTime = DateTime(
            todo.dateTime.year, todo.dateTime.month, todo.dateTime.day);

        timeTodosMap.update(roundedDateTime, (List<Todo> update) {
          List<Todo> previousEvents = timeTodosMap[roundedDateTime];
          previousEvents.add(todo);
          return previousEvents;
        }, ifAbsent: () => [todo]);
      }
    }

    return timeTodosMap;
  }
}
