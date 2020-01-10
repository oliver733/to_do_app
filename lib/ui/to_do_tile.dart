import 'package:flutter/material.dart';
import 'package:to_do_list/colors.dart';
import 'package:to_do_list/data/to_do_model.dart';
import 'package:intl/intl.dart';

class TodoTile extends StatelessWidget {
  final Todo item;

  TodoTile({@required this.item});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100, // TODO: make responsive
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        color: MyColors.purpleBlue,
        child: ListTile(
          contentPadding: EdgeInsets.all(15),
          // dense: true,
          title: Text(
            item.task,
            style: TextStyle(color: Colors.white),
          ),
          leading: Text(
            item.dateTime != null
                ? "${DateFormat.jm().format(item.dateTime)}"
                : "--:--",
            style: TextStyle(color: Colors.white),
          ),
          trailing: Icon(Icons.check_box, color: Colors.white),
        ),
      ),
    );
  }
}
