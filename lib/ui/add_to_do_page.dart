import 'package:flutter/material.dart';
import 'package:to_do_list/colors.dart';

class AddToDoPage extends StatefulWidget {
  @override
  _AddToDoPageState createState() => _AddToDoPageState();
}

class _AddToDoPageState extends State<AddToDoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Done",
              style: TextStyle(
                  color: MyColors.purpleBlue,
                  fontWeight: FontWeight.w900,
                  fontSize: 20),
            ),
            onPressed: () {
              //
            },
          )
        ],
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: EdgeInsets.all(40),
      child: ListView(
        children: <Widget>[
          TextField(
            maxLines: 4,
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.normal,
            ),
            cursorWidth: 6,
            cursorColor: MyColors.purpleBlue,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: " What to do..",
                hintStyle: TextStyle(
                    color: MyColors.grey,
                    fontSize: 30,
                    fontWeight: FontWeight.w800)),
          ),
          Column(
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(Icons.access_time),
                title: Text("8:00 AM"),
              ),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(Icons.calendar_today),
                title: Text("14 August 2020"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
