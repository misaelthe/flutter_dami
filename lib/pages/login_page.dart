import 'package:flutter/material.dart';
import 'package:flutter_dami/controller/LoginCtrlr.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formLoginKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _usuario, _password;
  String path;

  LoginCtrl loginCtr;

  @override
  Widget build(BuildContext context) {
    var btnLogin = new RaisedButton(
      onPressed: _submit,
      child: Text("Login"),
    );
    var formLogin = new Form(
      key: _formLoginKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            decoration:
                InputDecoration(border: InputBorder.none, hintText: 'Usuario'),
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (val) => _usuario = val,
          ),
          TextField(
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Contraseña'),
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (val) => _password = val,
          ),
          btnLogin
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      key: scaffoldKey,
      body: formLogin,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _submit() async {
    final form = _formLoginKey.currentState;
    int _credencial;
    loginCtr = new LoginCtrl();
    if (form.validate()) {
      setState(() {
        form.save();
        loginCtr.login(_usuario, _password);
      });
      SharedPreferences preferences = await SharedPreferences.getInstance();
      _credencial = preferences.getInt("credencial");
      path = _credencial == 1
          ? "/homePageDocente"
          : (_credencial == 2 ? "/homePageAlumno" : "/homePageAlumno");
      Navigator.of(context).pushNamed(path);
    }
  }
}
