import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/colors.dart';
import 'package:to_do_list/data/bloc/bloc.dart';
import 'package:to_do_list/data/bloc/to_do_bloc.dart';
import 'package:to_do_list/data/bloc/to_do_event.dart';
import 'package:to_do_list/ui/calender_view.dart';
import 'package:to_do_list/ui/widgets/cirlce_tab_indicator.dart';

import 'add_to_do_page.dart';
import 'deadline_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddToDoPage()));
            },
          )
        ],
      ),
      body: SafeArea(
        child: Container(padding: EdgeInsets.all(10), child: _body()),
      ),
    );
  }

  Widget _body() {
    return BlocBuilder<TodoBloc, ToDoState>(builder: (context, toDoState) {
      if (toDoState is TodosLoaded) {
        return TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: <Widget>[
            CalenderView(
              todos: toDoState.todos,
            ),
            DeadlineView(
              todos: toDoState.todos,
            ),
          ],
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
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
}
