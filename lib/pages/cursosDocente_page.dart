import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dami/controller/DocenteCtrlr.dart';
import 'package:flutter_dami/model/Clase.dart';
import 'package:flutter_dami/model/Curso.dart';

class CoursesDocentePage extends StatefulWidget {
  @override
  _CoursesDocentePageState createState() => _CoursesDocentePageState();
}

class _CoursesDocentePageState extends State<CoursesDocentePage> {
  DocenteCtrl docCtrl = new DocenteCtrl();
  int iddocente;
  Clase claTem;
  Curso curTem;
  String nomCurso;
  Future<List<Clase>> _clases;

  @override
  void initState() {
    super.initState();
    //setIdDocente();
    _clases = setClases() as Future<List<Clase>>;
    print("impirme esto please");
  }

  setClases() async {
    int iddoc = await docCtrl.getIdDocente();
    print(iddoc.toString());
    return await docCtrl.getClasesByDocente(iddoc);
  }

  @override
  Widget build(BuildContext context) {
    print("antesito del scaffold");
    return Scaffold(
        appBar: AppBar(
          title: Text("Clases Dictadas"),
        ),
        body: FutureBuilder<List<Clase>>(
            future: _clases,
            builder: (context, AsyncSnapshot<List<Clase>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      print("una iteracion");
                      Clase c = snapshot.data[index];
                      setCursoXClaseActual(c.idcurso);
                      return ListTile(
                        title: Text(nomCurso),
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
    int iddoc = await docCtrl.getIdDocente();
    setState(() {
      iddocente = iddoc;
    });
  }

  Future<List<Clase>> getClases() async {
    return await docCtrl.getClasesByDocente(iddocente);
  }

  setCursoXClaseActual(int idclase) async {
    String tem = await docCtrl.getCursoByClase(idclase);
    setState(() {
      nomCurso = tem;
    });
  }
  //await docCtrl .getCursoByClase(c.idclase).toString()
}
