import 'package:flutter/material.dart';
import 'package:flutter_dami/controller/AlumnoCtrl.dart';
import 'package:flutter_dami/model/Clase.dart';
import 'package:flutter_dami/model/Curso.dart';
import 'package:flutter_dami/model/Seccion.dart';
import 'package:flutter_dami/pages/alumno/listNotas_AlumnoPage.dart';

class ListClasesAlumnoPage extends StatefulWidget {
  @override
  _ListClasesAlumnoPage createState() => _ListClasesAlumnoPage();
}

class _ListClasesAlumnoPage extends State<ListClasesAlumnoPage> {
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
    int idalumno = await alCtrl.getIdAlumno();
    List<Clase> tem = await alCtrl.getClasesByAlumno(idalumno);
    for (Clase c in tem) {
      Curso curso = await alCtrl.getCursoByClase(c.idclase);
      Seccion seccion = await alCtrl.getSeccionByClase(c.idclase);
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
        subtitle: Text("Seccion: " + seccion.codigo.toString()),
        onTap: () => {goPageVerNotas(context, c.idclase)},
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
          title: Text("Clases Actuales"),
        ),
        body: ListView(
          children: loading ? [] : _arListTile,
        ));
  }

  goPageVerNotas(BuildContext context, int idcla) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListNotasAlumnoPage(
                  idclase: idcla,
                )));
  }
}
