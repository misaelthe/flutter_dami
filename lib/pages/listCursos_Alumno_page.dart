import 'package:flutter/material.dart';
import 'package:flutter_dami/controller/AlumnoCtrl.dart';
import 'package:flutter_dami/model/Clase.dart';
import 'package:flutter_dami/model/Curso.dart';
import 'package:flutter_dami/pages/listNotas_Alumno_Page.dart';

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
    int idalumno = await alCtrl.getIdAlumno();
    print(idalumno.toString() + "  ese se su id del alumn");
    List<Clase> tem = await alCtrl.getClasesByAlumno(idalumno);
    print(tem.length.toString() + "  ese es la lonmg dela rray alumn");
    for (Clase c in tem) {
      Curso curso = await alCtrl.getCursoByClase(c.idclase);
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
          title: Text("Cursos Actuales"),
        ),
        body: ListView(
          children: loading ? [] : _arListTile,
        ));
  }

  goPageVerNotas(BuildContext context, int idcla) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListarNotasAlumnoPage(
                  idclase: idcla,
                )));
  }
}
