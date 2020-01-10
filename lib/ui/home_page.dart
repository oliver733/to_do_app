import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:to_do_list/colors.dart';
import 'package:to_do_list/data/to_do_model.dart';
import 'package:to_do_list/ui/to_do_tile.dart';
import 'package:to_do_list/ui/widgets/cirlce_tab_indicator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Map<DateTime, List> _eventsDateMap = {};
  TabController _tabController;
  List _selectedItems = [];
  DateTime _selectedDay;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    final today = DateTime.now();
    _selectedDay = DateTime(today.year, today.month, today.day);
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();

    _updateEventsDateMap();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedDay = day;
      _selectedItems = events;
    });
  }

  void _updateEventsDateMap() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: _calenderDeadlinesSwitch(),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: MyColors.grey,
            ),
            onPressed: () {
              // Navigator.pushNamed(context, CreateEventScreen.routeName);
            },
          )
        ],
      ),
      body: _body(),
    );
  }

  Widget _calenderDeadlinesSwitch() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TabBar(
        indicator: CircleTabIndicator(color: MyColors.purpleBlue, radius: 4),
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        labelColor: MyColors.purpleBlue,
        unselectedLabelColor: MyColors.grey,
        unselectedLabelStyle: TextStyle(fontSize: 16),
        // indicatorColor: MyColors.blue,
        indicatorSize: TabBarIndicatorSize.tab,
        controller: _tabController,
        tabs: <Widget>[
          Tab(
            child: Text(
              "Calender",
            ),
          ),
          Tab(
            child: Text(
              "Deadlines",
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
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
            events: _eventsDateMap,
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
          padding: EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              Text(
                'Today',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
              ),
              SizedBox(
                width: 20,
              ),
              FloatingActionButton(
                backgroundColor: MyColors.purpleBlue,
                child: Icon(Icons.add),
                onPressed: () {},
              )
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: _buildEventList(),
          ),
        ),
      ],
    );
  }

  Widget _buildEventList() {
    return ListView.builder(
      itemCount: 4,
      // _selectedItems.length,
      itemBuilder: (context, index) {
        return TodoTile(
            item: ToDoItem(
                dateTime: DateTime.now(), title: "TITLE", finished: false)
            // _selectedItems[index],
            );
      },
    );
  }
}
