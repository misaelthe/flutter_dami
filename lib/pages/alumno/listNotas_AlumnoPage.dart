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
  var tableNota;
  final styleHeader = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );
  final styleBody = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: 18,
  );
  @override
  void initState() {
    setNotas();
    super.initState();
  }

  setNotas() async {
    Nota n = await alCtrl.getNotaByClase(widget.idclase);
    tableNota = new Table(
      columnWidths: {1: FlexColumnWidth(.3)},
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(children: [
          Text(
            "Nombre de la Evaluacion",
            style: styleHeader,
            textAlign: TextAlign.center,
          ),
          Text(
            "Nota",
            style: styleHeader,
            textAlign: TextAlign.center,
          ),
        ]),
        TableRow(
          children: [
            Text(
              "Evaluacion Teorica 1",
              style: styleBody,
              textAlign: TextAlign.center,
            ),
            Text(
              n.e1.toString(),
              style: styleBody,
              textAlign: TextAlign.center,
            ),
          ],
          decoration: BoxDecoration(color: Colors.grey[200]),
        ),
        TableRow(children: [
          Text(
            "Evaluacion Teorica 2",
            style: styleBody,
            textAlign: TextAlign.center,
          ),
          Text(
            n.e2.toString(),
            style: styleBody,
            textAlign: TextAlign.center,
          ),
        ]),
        TableRow(
          children: [
            Text(
              "Evaluacion Parcial",
              style: styleBody,
              textAlign: TextAlign.center,
            ),
            Text(
              n.ep.toString(),
              style: styleBody,
              textAlign: TextAlign.center,
            ),
          ],
          decoration: BoxDecoration(color: Colors.grey[200]),
        ),
        TableRow(children: [
          Text(
            "Evaluacion Teorica 3",
            style: styleBody,
            textAlign: TextAlign.center,
          ),
          Text(
            n.e3.toString(),
            style: styleBody,
            textAlign: TextAlign.center,
          ),
        ]),
        TableRow(
          children: [
            Text(
              "Evaluacion Final",
              style: styleBody,
              textAlign: TextAlign.center,
            ),
            Text(
              n.ef.toString(),
              style: styleBody,
              textAlign: TextAlign.center,
            ),
          ],
          decoration: BoxDecoration(color: Colors.grey[200]),
        ),
      ],
      border: TableBorder(
          horizontalInside: BorderSide(
              width: 2, color: Colors.blue, style: BorderStyle.solid),
          verticalInside: BorderSide(
              width: 1, color: Colors.blue, style: BorderStyle.solid)),
    );

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
      body: Container(
        padding: EdgeInsets.only(bottom: 20.0),
        child: tableNota,
      ),
    );
  }
}
