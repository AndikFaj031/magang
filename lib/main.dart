// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'screens_loginregister/login_main.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        disabledColor: Colors.grey,
        primarySwatch: Colors.indigo,
        fontFamily: 'SFPro',
      ),
      home: LoginMainPage(),
    );
  }
}
