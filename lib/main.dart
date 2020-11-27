import 'package:flutter/cupertino.dart';
import 'package:flutter_dami/pages/docente/listClases_DocentePage.dart';
import 'package:flutter_dami/pages/alumno/alumnoPage.dart';
import 'package:flutter_dami/pages/docente/docentePage.dart';
import 'package:flutter_dami/pages/alumno/listClases_AlumnoPage.dart';
import 'package:flutter_dami/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

final routes = {
  '/login': (BuildContext context) => new LoginPage(),
  '/homePageDocente': (BuildContext context) => new DocenteHomePage(),
  '/pageClasesDocente': (BuildContext context) => new ListClasesDocentePage(),
  '/homePageAlumno': (BuildContext context) => new AlumnoHomePage(),
  '/pageClasesAlumno': (BuildContext context) => new ListClasesAlumnoPage(),
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
