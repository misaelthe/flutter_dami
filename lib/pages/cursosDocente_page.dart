import 'package:flutter/material.dart';
import 'package:flutter_dami/controller/DocenteCtrlr.dart';
import 'package:flutter_dami/model/Clase.dart';

class CoursesDocentePage extends StatefulWidget {
  @override
  _CoursesDocentePageState createState() => _CoursesDocentePageState();
}

class _CoursesDocentePageState extends State<CoursesDocentePage> {
  DocenteCtrl docCtrl = new DocenteCtrl();
  int iddocente;
  @override
  Widget build(BuildContext context) {
  setIdDocente();

    return Scaffold(
        appBar: AppBar(
          title: Text("Cursos Dictados"),
        ),
        body: Container(child: FutureBuilder(
          future: docCtrl.getClasesByDocente(iddocente),
          builder: (BuildContext context,),
        )));
  }

  setIdDocente() async {
    iddocente = await docCtrl.getIdDocente();
  }
}
