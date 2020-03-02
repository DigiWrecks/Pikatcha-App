import 'package:flutter/material.dart';
import 'package:pikatcha/screens/contact-information.dart';
import 'package:pikatcha/screens/home.dart';
import 'package:pikatcha/screens/login.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.white,
        scaffoldBackgroundColor: Color(0xfff2f2f2),
      ),

      home: LogIn(),
    );
  }
}