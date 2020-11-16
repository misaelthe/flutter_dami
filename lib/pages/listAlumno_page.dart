import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dami/controller/DocenteCtrlr.dart';
import 'package:flutter_dami/model/Alumno.dart';
import 'package:flutter_dami/model/Clase.dart';
import 'package:flutter_dami/model/Curso.dart';

class ListAlumnoPage extends StatefulWidget {
  final int iddocente;
  final int idclase;
  const ListAlumnoPage({Key key, this.iddocente, this.idclase})
      : super(key: key);
  @override
  _ListAlumnoPageState createState() => _ListAlumnoPageState();
}

class _ListAlumnoPageState extends State<ListAlumnoPage> {
  DocenteCtrl docCtrl = new DocenteCtrl();
  List<Widget> _arListTile;
  bool loading = true;

  @override
  void initState() {
    setArrayAlumnos();
    super.initState();
  }

  setArrayAlumnos() async {
    List<Widget> data = new List<Widget>();
    List<Alumno> tem = await docCtrl.getAlumnosByClase(widget.idclase);
    for (Alumno a in tem) {
      data.add(new ListTile(
        leading: Icon(
          Icons.architecture,
          size: 50,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 30,
        ),
        title: Text(a.nombre),
        subtitle: Text("Correo: " + a.correo),
        onTap: () => {},
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
          title: Text("Alumnos de la Clase"),
        ),
        body: ListView(
          children: loading ? [] : _arListTile,
        ));
  }
}
