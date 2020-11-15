import 'package:flutter/material.dart';
import 'package:flutter_dami/controller/DocenteCtrlr.dart';
import 'package:flutter_dami/model/Clase.dart';

class CoursesDocentePage extends StatefulWidget {
  @override
  _CoursesDocentePageState createState() => _CoursesDocentePageState();
}

class _CoursesDocentePageState extends State<CoursesDocentePage> {
  DocenteCtrl docCtrl = new DocenteCtrl();
  int iddocente;
  @override
  Widget build(BuildContext context) {
    setIdDocente();

    return Scaffold(
        appBar: AppBar(
          title: Text("Clases Dictadas"),
        ),
        body: FutureBuilder<List<Clase>>(
            future: docCtrl.getClasesByDocente(iddocente),
            builder:
                (BuildContext context, AsyncSnapshot<List<Clase>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Clase c = snapshot.data[index];
                      return ListTile(
                        title:
                            Text(docCtrl.getCursoByClase(c.idclase).toString()),
                        leading: Icon(Icons.accessibility),
                        onTap: () => {},
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  setIdDocente() async {
    iddocente = await docCtrl.getIdDocente();
  }
}
