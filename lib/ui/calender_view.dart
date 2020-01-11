import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:to_do_list/data/models/all_todos_model.dart';
import 'package:to_do_list/data/models/todo_item_model.dart';
import 'package:to_do_list/ui/to_do_tile.dart';
import 'package:intl/intl.dart';
import '../colors.dart';
import 'add_to_do_page.dart';

class CalenderView extends StatefulWidget {
  final AllTodos allTodos;

  CalenderView({@required this.allTodos});

  @override
  _CalenderViewState createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView>
    with TickerProviderStateMixin {
  DateTime _selectedDay;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    final today = DateTime.now();
    _selectedDay = DateTime(today.year, today.month, today.day);
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, dynamic todos) {
    setState(() {
      _selectedDay = DateTime(day.year, day.month, day.day);
    });
  }

  String _getSelectedDateString() {
    DateTime now = DateTime.now();

    DateTime selectedDay =
        DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    if (selectedDay == DateTime(now.year, now.month, now.day - 1)) {
      return "Yesterday";
    } else if (selectedDay == DateTime(now.year, now.month, now.day)) {
      return "Today";
    } else if (selectedDay == DateTime(now.year, now.month, now.day + 1)) {
      return "Tomorrow";
    } else {
      return "${DateFormat.MMMEd().format(selectedDay)}";
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.allTodos.todos.length);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TableCalendar(
            rowHeight: MediaQuery.of(context).size.height / 20,
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle().copyWith(color: Colors.black),
              weekendStyle: TextStyle().copyWith(color: Colors.black),
            ),
            headerVisible: true,
            calendarController: _calendarController,
            events: widget.allTodos.calenderMap,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
                weekendStyle: TextStyle(
                  color: Colors.black,
                ),
                // todayColor: MyColors.GreyBlue,
                // selectedColor: MyColors.LightBlue,
                // markersColor: MyColors.DarkBlue,
                markersMaxAmount: 1,
                outsideDaysVisible: false,
                canEventMarkersOverflow: false),
            headerStyle: HeaderStyle(
              centerHeaderTitle: false,
              titleTextStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                // color: MyColors.LightBlue,
              ),
              formatButtonVisible: false,
            ),
            onDaySelected: _onDaySelected),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Row(
            children: <Widget>[
              Text(
                _getSelectedDateString(),
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
              ),
              SizedBox(
                width: 20,
              ),
              FloatingActionButton(
                backgroundColor: MyColors.purpleBlue,
                child: Icon(Icons.add),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddToDoPage(date: _selectedDay),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        Expanded(
          child: _showTodosList(
              todos: widget.allTodos.calenderMap[_selectedDay] ?? []),
        ),
      ],
    );
  }

  Widget _showTodosList({@required List<Todo> todos}) {
    print(todos);
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return TodoTile(item: todos[index]);
      },
    );
  }
}
