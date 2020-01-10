import 'package:flutter/material.dart';
import 'package:to_do_list/data/to_do_model.dart';

class ToDoRepository {
  Future<List<Todo>> loadTodos() async {
    List<Todo> todos = []; //TODO: get todos from sql..

    return todos;
  }

  Future<void> saveTodos({
    @required List<Todo> todos,
  }) async {} //TODO Save to db
}

// void _updateEventsDateMap() async {
// Set<String> combined = {};
// // combined.addAll(Provider.of<AttendingEvents>(context, listen: false).value);
// // combined.addAll(Provider.of<OwnEvents>(context, listen: false).value);

// List<Event> events =
//     await Provider.of<CacheBloc>(context, listen: false).idsToEvents(
//   List<String>.from(combined),
// );
// Map<DateTime, List<Event>> timeEventsMap = {};
// for (Event event in events) {
//   if (event.startTime != null) {
//     DateTime roundedDateTime = DateTime(
//         event.startTime.year, event.startTime.month, event.startTime.day);

//     timeEventsMap.update(roundedDateTime, (List<Event> update) {
//       List<Event> previousEvents = timeEventsMap[roundedDateTime];
//       previousEvents.add(event);
//       return previousEvents;
//     }, ifAbsent: () => [event]);
//   }
// }

// if (mounted) {
//   setState(() {
//     _eventsDateMap = timeEventsMap;
//     _selectedEvents = _eventsDateMap[_selectedDay] ?? [];
//   });
// }
// }
