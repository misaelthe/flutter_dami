import 'package:flutter/material.dart';
import 'package:flutter_dami/controller/DocenteCtrlr.dart';
import 'package:flutter_dami/model/Clase.dart';
import 'package:flutter_dami/model/Curso.dart';
import 'package:flutter_dami/model/Seccion.dart';
import 'package:flutter_dami/pages/docente/listAlumnos_DocentePage.dart';

class ListClasesDocentePage extends StatefulWidget {
  @override
  _ListClasesDocentePage createState() => _ListClasesDocentePage();
}

class _ListClasesDocentePage extends State<ListClasesDocentePage> {
  DocenteCtrl docCtrl = new DocenteCtrl();
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
      Seccion seccion = await docCtrl.getSeccionByClase(c.idclase);
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
        subtitle: Text("Seccion: " +
            seccion.codigo.toString() +
            "Ciclo: " +
            curso.ciclo.toString()),
        onTap: () => {goPageListAlumnos(context, iddocente, c.idclase)},
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

  goPageListAlumnos(BuildContext context, int iddoc, int idcla) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListAlumnosDocentePage(
                  iddocente: iddoc,
                  idclase: idcla,
                )));
  }
}
