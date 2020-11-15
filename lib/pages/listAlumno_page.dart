import 'package:flutter/material.dart';
import 'package:flutter_dami/controller/DocenteCtrlr.dart';

class ListAlumnoPage extends StatelessWidget {
  final List<DataRow> rows = [];
  final DocenteCtrl docenteCtrl = new DocenteCtrl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: datatable(),
    );
  }

  fillDataTable() async {
    /*await docenteCtrl.getAlumno().then((value) => {
          value.forEach((element) {
            rows.add(DataRow(cells: [
              DataCell(Text(element.idalumno.toString())),
              DataCell(Text(element.nombre))
            ]));
          })
        });*/
  }

  SingleChildScrollView datatable() {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(columns: [
          DataColumn(label: Text("")),
          DataColumn(label: Text("Alumno"))
        ], rows: rows));
  }
}
