import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dami/controller/DocenteCtrlr.dart';

class ListarNotasDocentePage extends StatefulWidget {
  final int idalumno;
  final int idclase;
  const ListarNotasDocentePage({Key key, this.idalumno, this.idclase})
      : super(key: key);
  @override
  _ListarNotasDocentePageState createState() => _ListarNotasDocentePageState();
}

class _ListarNotasDocentePageState extends State<ListarNotasDocentePage> {
  DocenteCtrl docCtrl = new DocenteCtrl();
  List<Widget> _arListTile;
  bool loading = true;
  final _formRegistrarNota = GlobalKey<FormState>();
  int _e1, _e2, _e3, _ep, _ef;

  @override
  void initState() {
    //setArrayCursos();
    super.initState();
  }

  /* setArrayCursos() async {
    List<Widget> data = new List<Widget>();
    int iddocente = await docCtrl.getIdDocente();
    List<Clase> tem = await docCtrl.getClasesByDocente(iddocente);
    for (Clase c in tem) {
      Curso curso = await docCtrl.getCursoByClase(c.idclase);
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
        onTap: () => {goPageListAlumnos(context, iddocente, c.idclase)},
      ));
    }
    setState(() {
      _arListTile = data;
      loading = false;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    var formRegistrarNota = new Form(
      key: _formRegistrarNota,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Nota Teorica 1'),
            readOnly: true,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: <FilteringTextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            validator: (value) {
              if (int.parse(value) > 20 || int.parse(value) < 0) {
                return 'Ingrese una nota valida';
              }
              return null;
            },
            onSaved: (val) => _e1 = int.parse(val),
          ),
          TextField(
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Nota Teorica 2'),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: <FilteringTextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            validator: (value) {
              if (int.parse(value) > 20 || int.parse(value) < 0) {
                return 'Ingrese una nota valida';
              }
              return null;
            },
            onSaved: (val) => _e2 = int.parse(val),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Notas Obtenidas"),
      ),
      body: formRegistrarNota,
    );
  }
}
