import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dami/controller/DocenteCtrlr.dart';
import 'package:flutter_dami/model/Nota.dart';

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
  bool loading = true;
  int _idnota, _e1, _e2, _e3, _ep, _ef;
  var formNotas;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    setNotas();
    super.initState();
  }

  setNotas() async {
    Nota n =
        await docCtrl.getNotaByClaseByAlumno(widget.idclase, widget.idalumno);
    print("la nota es esta al set: " +
        n.idnota.toString() +
        " y " +
        n.e1.toString() +
        n.e2.toString());
    formNotas = new Form(
      key: _formKey,
      child: Column(
        children: [
          Text("Evaluacion Teorica 1"),
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: <FilteringTextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: const InputDecoration(
              hintText: '',
            ),
            initialValue: n.e1.toString(),
            validator: (value) {
              if (int.parse(value) > 20 || int.parse(value) < 0) {
                return 'Ingrese una nota valida';
              }
              return null;
            },
            onSaved: (val) => _e1 = int.parse(val),
          ),
          Text("Evaluacion Teorica 2"),
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: <FilteringTextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: const InputDecoration(
              hintText: '',
            ),
            initialValue: n.e2.toString(),
            validator: (value) {
              if (int.parse(value) > 20 || int.parse(value) < 0) {
                return 'Ingrese una nota valida';
              }
              return null;
            },
            onSaved: (val) => _e2 = int.parse(val),
          ),
          Text("Evaluacion Parcial"),
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: <FilteringTextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: const InputDecoration(
              hintText: '',
            ),
            initialValue: n.ep.toString(),
            validator: (value) {
              if (int.parse(value) > 20 || int.parse(value) < 0) {
                return 'Ingrese una nota valida';
              }
              return null;
            },
            onSaved: (val) => _ep = int.parse(val),
          ),
          Text("Evaluacion Teorica 3"),
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: <FilteringTextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: const InputDecoration(
              hintText: '',
            ),
            initialValue: n.e3.toString(),
            validator: (value) {
              if (int.parse(value) > 20 || int.parse(value) < 0) {
                return 'Ingrese una nota valida';
              }
              return null;
            },
            onSaved: (val) => _e3 = int.parse(val),
          ),
          Text("Evaluacion Final"),
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: <FilteringTextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: const InputDecoration(
              hintText: '',
            ),
            initialValue: n.ef.toString(),
            validator: (value) {
              if (int.parse(value) > 20 || int.parse(value) < 0) {
                return 'Ingrese una nota valida';
              }
              return null;
            },
            onSaved: (val) => _ef = int.parse(val),
          ),
          Text("Promedio"),
          TextFormField(
            readOnly: true,
            enabled: false,
            initialValue: n.promedio.toString(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  print("la nota es esta: " + _idnota.toString());
                  actualizarNota();
                  showDialog(
                      context: context,
                      builder: (_) => new AlertDialog(
                            title: new Text("Nota Registrada"),
                            content: new Text("Felicidades Teacher"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          ));
                }
              },
              child: Text('Registrar Nota'),
            ),
          ),
        ],
      ),
    );
    setState(() {
      loading = false;
      _idnota = n.idnota;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notas Obtenidas"),
      ),
      body: formNotas,
    );
  }

  actualizarNota() {
    final form = _formKey.currentState;
    form.save();
    docCtrl.registrarNota(_idnota, _e1, _e2, _ep, _e3, _ef);
  }
}
