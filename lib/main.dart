import 'package:flutter/cupertino.dart';
import 'package:flutter_dami/home_page.dart';
import 'package:flutter_dami/login_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

final routes = {
  '/login': (BuildContext context) => new LoginPage(),
  '/home': (BuildContext context) => new HomePage(),
  '/': (BuildContext context) => new LoginPage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter DAMI",
      theme: ThemeData(primaryColor: Colors.amber),
      initialRoute: '/login',
      routes: routes,
    );
  }
}
