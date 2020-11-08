import 'package:flutter/cupertino.dart';
import 'package:flutter_dami/pages/CoursesDocente_page.dart';
import 'package:flutter_dami/pages/alumno_page.dart';
import 'package:flutter_dami/pages/docente_page.dart';
import 'package:flutter_dami/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

final routes = {
  '/login': (BuildContext context) => new LoginPage(),
  '/homePageDocente': (BuildContext context) => new DocenteHomePage(),
  '/pageCoursesDocente': (BuildContext context) => new CoursesDocente(),
  '/homePageAlumno': (BuildContext context) => new AlumnoHomePage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter DAMI",
      theme: ThemeData(primaryColor: Colors.blueAccent),
      initialRoute: '/login',
      routes: routes,
    );
  }
}
