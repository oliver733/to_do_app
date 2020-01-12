import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/data/models/all_todos_model.dart';
import 'package:to_do_list/data/models/todo_item_model.dart';
import 'package:to_do_list/data/todo_database.dart';
import './bloc.dart';

class TodoBloc extends Bloc<ToDoEvent, ToDoState> {
  final TodoDatabase _todoDatabase = TodoDatabase();

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
      List<Todo> todos = await _todoDatabase.todos();
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
      await _todoDatabase.insertTodo(
          todo: event.todo); //TODO: after yielding state ?
      yield TodosLoaded(
          AllTodos(todos: updatedTodos, calenderMap: updatedCalenderMap));
    }
  }

  Stream<ToDoState> _mapUpdateTodoToState(UpdateTodo event) async* {
    if (state is TodosLoaded) {
      List<Todo> updatedTodos =
          (state as TodosLoaded).allTodos.todos.map((todo) {
        return todo.id == event.updatedTodo.id ? event.updatedTodo : todo;
      }).toList();

      Map<DateTime, List<Todo>> updatedCalenderMap =
          _updateEventsDateMap(todos: updatedTodos);
      await _todoDatabase.updateTodo(
          todo: event.updatedTodo); //TODO: after yielding state ?
      yield TodosLoaded(
          AllTodos(todos: updatedTodos, calenderMap: updatedCalenderMap));
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
      await _todoDatabase.deleteTodo(
          id: event.todo.id); //TODO: after yielding state ?
      yield TodosLoaded(
          AllTodos(todos: updatedTodos, calenderMap: updatedCalenderMap));
    }
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
