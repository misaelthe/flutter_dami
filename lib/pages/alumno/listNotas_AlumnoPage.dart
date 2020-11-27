import 'package:flutter/material.dart';
import 'package:flutter_dami/controller/AlumnoCtrl.dart';
import 'package:flutter_dami/model/Nota.dart';

class ListNotasAlumnoPage extends StatefulWidget {
  final int idclase;
  const ListNotasAlumnoPage({Key key, this.idclase}) : super(key: key);
  @override
  _ListNotasAlumnoPage createState() => _ListNotasAlumnoPage();
}

class _ListNotasAlumnoPage extends State<ListNotasAlumnoPage> {
  AlumnoCtrl alCtrl = new AlumnoCtrl();
  bool loading = true;
  final _formKey = GlobalKey<FormState>();
  var formFinal;
  @override
  void initState() {
    setNotas();
    super.initState();
  }

  setNotas() async {
    Nota n = await alCtrl.getNotaByClase(widget.idclase);
    formFinal = new Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Evaluacion Teorica 1: " + n.e1.toString()),
              Text("Evaluacion Teorica 2: " + n.e2.toString()),
              Text("Evaluacion Parcial: " + n.ep.toString()),
              Text("Evaluacion Teorica 3: " + n.e3.toString()),
              Text("Evaluacion Final: " + n.ef.toString()),
            ]));
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notas Obtenidas"),
      ),
      body: formFinal,
    );
  }
}
