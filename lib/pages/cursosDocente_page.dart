import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dami/controller/DocenteCtrlr.dart';
import 'package:flutter_dami/model/Clase.dart';
import 'package:flutter_dami/model/Curso.dart';

class CoursesDocentePage extends StatefulWidget {
  @override
  _CoursesDocentePageState createState() => _CoursesDocentePageState();
}

class _CoursesDocentePageState extends State<CoursesDocentePage> {
  DocenteCtrl docCtrl = new DocenteCtrl();
  Clase claTem;
  Curso curTem;
  String nomCurso;
  List<Widget> _arListTile;
  bool loading = true;

  @override
  void initState() {
    setArrayCursos();
    super.initState();
  }

  setArrayCursos() async {
    List<Widget> data = new List<Widget>();
    int iddocente = await docCtrl.getIdDocente();
    List<Clase> tem = await docCtrl.getClasesByDocente(iddocente);
    for (Clase c in tem) {
      Curso curso = await docCtrl.getCursoByClase(c.idclase);
      data.add(new ListTile(
        leading: Icon(
          Icons.architecture,
          size: 50,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 30,
        ),
        title: Text(curso.nombre),
        subtitle: Text("Ciclo: " + curso.ciclo.toString()),
        onTap: () => {goPageListAlumnos(context)},
      ));
    }
    setState(() {
      _arListTile = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Clases Dictadas"),
        ),
        body: ListView(
          children: loading ? [] : _arListTile,
        ));
  }

  goPageListAlumnos(BuildContext context) {}
}
