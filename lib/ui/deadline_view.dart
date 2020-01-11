import 'package:flutter/material.dart';
import 'package:to_do_list/data/to_do_model.dart';
import 'package:to_do_list/ui/to_do_tile.dart';

import '../colors.dart';
import 'add_to_do_page.dart';

class DeadlineView extends StatefulWidget {
  final List<Todo> todos;

  DeadlineView({@required this.todos});

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
            itemCount: widget.todos.length,
            itemBuilder: (context, index) {
              return TodoTile(item: widget.todos[index]);
            },
          ),
        ),
        Container(
          alignment: Alignment.bottomRight,
          padding: EdgeInsets.all(20),
          child: FloatingActionButton(
            backgroundColor: MyColors.purpleBlue,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddToDoPage(), // TODO: set setting to deadline
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
