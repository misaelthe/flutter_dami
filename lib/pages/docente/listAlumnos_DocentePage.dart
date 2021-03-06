import 'package:flutter/material.dart';
import 'package:flutter_dami/controller/DocenteCtrlr.dart';
import 'package:flutter_dami/model/Alumno.dart';
import 'package:flutter_dami/pages/docente/listNotas_DocentePage.dart';

class ListAlumnosDocentePage extends StatefulWidget {
  final int iddocente;
  final int idclase;
  const ListAlumnosDocentePage({Key key, this.iddocente, this.idclase})
      : super(key: key);
  @override
  _ListAlumnosDocentePage createState() => _ListAlumnosDocentePage();
}

class _ListAlumnosDocentePage extends State<ListAlumnosDocentePage> {
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
          Icons.account_circle,
          size: 50,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 30,
        ),
        title: Text(a.nombre),
        subtitle: Text("Cod. de Alumno: " + a.idalumno.toString()),
        onTap: () => {goPageListNotas(context, a.idalumno, widget.idclase)},
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

  goPageListNotas(BuildContext context, int idal, int idcla) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListNotasDocentePage(
                  idalumno: idal,
                  idclase: idcla,
                )));
  }
}
