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
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String _usuario, _password;
  String path;

  LoginCtrl loginCtr;

  @override
  Widget build(BuildContext context) {
    var btnLogin = new Material(
        elevation: 25.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xff01A0C7),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: _submit,
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ));

    var formLogin = new Form(
      key: _formLoginKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            obscureText: false,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Usuario",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
            validator: (value) {
              if (value.isEmpty) {
                return 'Ingrese el Usuario';
              }
              return null;
            },
            onSaved: (val) => _usuario = val,
          ),
          SizedBox(height: 30.0),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Password",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
            validator: (value) {
              if (value.isEmpty) {
                return 'Ingrese la Contraseña';
              }
              return null;
            },
            onSaved: (val) => _password = val,
          ),
          SizedBox(height: 45.0),
          btnLogin,
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text("Login")),
      key: scaffoldKey,
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [formLogin],
            ),
          ),
        ),
      ),
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
      try {
        form.save();
        loginCtr.login(_usuario, _password);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        _credencial = preferences.getInt("credencial");
        path = _credencial == 1
            ? "/homePageDocente"
            : (_credencial == 2 ? "/homePageAlumno" : "/homePageAlumno");
      } catch (e) {
        print("Incorrecto usaurio o login" + e);
      } finally {
        Navigator.of(context).pushNamed(path);
      }
    }
  }
}
