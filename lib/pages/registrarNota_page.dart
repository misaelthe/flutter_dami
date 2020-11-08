import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistrarNotaPage extends StatelessWidget {
  final _formRegistrarNota = GlobalKey<FormState>();
  int _e1, _e2, _e3, _ep, _ef;
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
      body: formRegistrarNota,
    );
  }
}
