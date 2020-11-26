import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dami/controller/AlumnoCtrl.dart';
import 'package:flutter_dami/controller/DocenteCtrlr.dart';
import 'package:flutter_dami/model/Clase.dart';
import 'package:flutter_dami/model/Curso.dart';
import 'package:flutter_dami/pages/listAlumno_page.dart';

class ListarCursosAlumnoPage extends StatefulWidget {
  @override
  _ListarCursosAlumnoPageState createState() => _ListarCursosAlumnoPageState();
}

class _ListarCursosAlumnoPageState extends State<ListarCursosAlumnoPage> {
  AlumnoCtrl alCtrl = new AlumnoCtrl();
  List<Widget> _arListTile;
  bool loading = true;

  @override
  void initState() {
    setArrayCursos();
    super.initState();
  }

 setArrayCursos() async {
    List<Widget> data = new List<Widget>();
    int idalumno = await aluCtrl.getIdAlumno();
    List<Clase> tem = await aluCtrl.getClasesByAlumno(idalumno);
    for (Clase c in tem) {
      Curso curso = await aluCtrl.getCursoByClase(c.idclase);
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
        onTap: () => {goPageListAlumnos(context, c.idclase)},
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
          title: Text("Cursos Actuales"),
        ),
        body: ListView(
          children: loading ? [] : _arListTile,
        ));
  }

    goPageListAlumnos(BuildContext context, int iddoc, int idcla) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListAlumnoPage(
                  iddocente: iddoc,
                  idclase: idcla,
                )));
  }
}
