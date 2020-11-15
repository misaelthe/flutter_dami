import 'package:flutter/material.dart';
import 'package:flutter_dami/controller/DocenteCtrlr.dart';
import 'package:flutter_dami/model/Usuario.dart';

class CoursesDocente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Cursos"),
      ),
      body: listCoursesForTeacher(),
    );
  }

  listCoursesForTeacher() {
    DocenteCtrl c = new DocenteCtrl();
    List<Widget> tem = new List<Widget>();
    /*.getCoursesForTeacher(1).then((value) {
      for (final Usuario u in value) {
        tem.add(Text(u.usuario));
      }
    });*/
    return new Row(children: tem);
  }
}
