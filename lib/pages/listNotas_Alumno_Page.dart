import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dami/controller/AlumnoCtrl.dart';
import 'package:flutter_dami/controller/DocenteCtrlr.dart';
import 'package:flutter_dami/model/Clase.dart';
import 'package:flutter_dami/model/Curso.dart';
import 'package:flutter_dami/model/Nota.dart';
import 'package:flutter_dami/pages/listAlumno_page.dart';

class ListarNotasAlumnoPage extends StatefulWidget {
  final int idclase;
  const ListarNotasAlumnoPage({Key key, this.idclase}) : super(key: key);
  @override
  _ListarNotasAlumnoPageState createState() => _ListarNotasAlumnoPageState();
}

class _ListarNotasAlumnoPageState extends State<ListarNotasAlumnoPage> {
  AlumnoCtrl alCtrl = new AlumnoCtrl();
  List<Widget> _notas;
  bool loading = true;
  final _formKey = GlobalKey<FormState>();
  Form formFinal;
  @override
  void initState() {
    setNotas();
    super.initState();
  }

  setNotas() async {
    Nota n = await alCtrl.getNotaByClase(widget.idclase);
    Form formNota = new Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Evaluacion Teorica 1" + n.e1.toString()),
              Text("Evaluacion Teorica 2" + n.e2.toString()),
              Text("Evaluacion Parcial" + n.ep.toString()),
              Text("Evaluacion Teorica 3" + n.e3.toString()),
              Text("Evaluacion Final" + n.ef.toString()),
            ]));
    setState(() {
      formFinal = formNota;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notas Obtenidas"),
        ),
        body: ListView(
          children: loading ? [] : formFinal,
        ));
  }
}
