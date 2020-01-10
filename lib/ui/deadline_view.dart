import 'package:flutter/material.dart';
import 'package:to_do_list/data/to_do_model.dart';
import 'package:to_do_list/ui/to_do_tile.dart';

import '../colors.dart';

class DeadlineView extends StatefulWidget {
  @override
  _DeadlineViewState createState() => _DeadlineViewState();
}

class _DeadlineViewState extends State<DeadlineView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: 50, //TODO: actual lenght.
            itemBuilder: (context, index) {
              return TodoTile(item: Todo("Task", complete: true, note: ''));
            },
          ),
        ),
        Container(
          alignment: Alignment.bottomRight,
          padding: EdgeInsets.all(20),
          child: FloatingActionButton(
            backgroundColor: MyColors.purpleBlue,
            child: Icon(Icons.add),
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
