import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list/colors.dart';
import 'package:to_do_list/strings.dart';
import 'package:to_do_list/ui/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.ubuntuTextTheme(),
          appBarTheme: AppBarTheme(
            textTheme: GoogleFonts.ubuntuTextTheme(TextTheme(
                title: TextStyle(
                    fontSize: 24,
                    color: MyColors.grey,
                    fontWeight: FontWeight.w600))),
            iconTheme: IconThemeData(color: Colors.black),
            brightness: (Platform.isIOS ? Brightness.light : null),
            color: Colors.white,
            elevation: 0,
          ),
          buttonTheme: ButtonThemeData(
              buttonColor: MyColors.purpleBlue,
              splashColor: Colors.transparent,
              padding: EdgeInsets.all(14),
              shape: StadiumBorder()),
        ),
        title: MyStrings.appName,
        home: HomePage());
  }
}
