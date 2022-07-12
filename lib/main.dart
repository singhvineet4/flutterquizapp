import 'package:flutter/material.dart';
import 'package:opentrivia/pages/answer.dart';
import 'package:opentrivia/pages/login_page.dart';
import 'package:opentrivia/pages/quiz.dart';
import 'package:opentrivia/pages/result_screen.dart';
import 'package:opentrivia/ui/pages/demo-registration.dart';
import 'package:opentrivia/ui/pages/home.dart';
import 'package:opentrivia/ui/pages/login_demo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hiring Mirror',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.indigo,
        fontFamily: "Montserrat",
        buttonColor: Colors.pink,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.pink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          textTheme: ButtonTextTheme.primary
        )
      ),
      home: Result(),
    );
  }
}
