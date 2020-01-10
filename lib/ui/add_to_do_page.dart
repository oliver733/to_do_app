import 'package:flutter/material.dart';
import 'package:to_do_list/colors.dart';
import 'package:intl/intl.dart';

class AddToDoPage extends StatefulWidget {
  @override
  _AddToDoPageState createState() => _AddToDoPageState();
}

class _AddToDoPageState extends State<AddToDoPage> {
  TimeOfDay _selectedTime;
  DateTime _selectedDate;

  Future<void> _selectTime() async {
    final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 12, minute: 0),
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (pickedTime != null && pickedTime != _selectedTime)
      setState(() {
        _selectedTime = pickedTime;
      });
  }

  Future<void> _selectDate() async {
    final DateTime pickedDate = await showDatePicker(
        firstDate: DateTime(2000),
        lastDate: DateTime(2200),
        context: context,
        initialDate: DateTime.now(),
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (pickedDate != null && pickedDate != _selectedDate)
      setState(() {
        _selectedDate = pickedDate;
      });
  }

  @override
  void initState() {
    super.initState();
  }

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
            autofocus: true,
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
                onTap: () async {
                  _selectTime();
                },
                contentPadding: EdgeInsets.all(0),
                leading: Icon(Icons.access_time),
                title: _selectedTime == null
                    ? Text(
                        "All day",
                        style: TextStyle(fontStyle: FontStyle.italic),
                      )
                    : Text(MaterialLocalizations.of(context)
                        .formatTimeOfDay(_selectedTime)),
              ),
              ListTile(
                onTap: () {
                  _selectDate();
                },
                contentPadding: EdgeInsets.all(0),
                leading: Icon(Icons.calendar_today),
                title: _selectedDate == null
                    ? Text(
                        "No date selected",
                        style: TextStyle(fontStyle: FontStyle.italic),
                      )
                    : Text("${DateFormat.yMMMd().format(_selectedDate)}"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
