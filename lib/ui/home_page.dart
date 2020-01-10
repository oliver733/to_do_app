import 'package:flutter/material.dart';
import 'package:to_do_list/colors.dart';
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
        child: Container(
            padding: EdgeInsets.all(10),
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: <Widget>[
                CalenderView(),
                DeadlineView(),
              ],
            )),
      ),
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
}
