import 'package:flutter/material.dart';
import 'package:flutter_dami/controller/LoginCtrlr.dart';
import 'package:flutter_dami/model/Usuario.dart';
import 'package:flutter_dami/services/mainService.dart';
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
  Usuario user;
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
    loginCtr = new LoginCtrl();
    if (form.validate()) {
      form.save();
      user = await loginCtr.login(_usuario, _password);
      if (user == null)
        showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                  title: new Text("Error"),
                  content: new Text("Datos Incorrectos, ¿Que intentas hacer?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Entiendo'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ));
      else {
        MainService m = new MainService();
        m.getAllClases();
        print("--------------------------------");
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool("isLoggedIn", true);
        preferences.setInt("idusuario", user.idusuario);
        preferences.setInt("credencial", user.credencial);
        path = user.credencial == 2
            ? "/homePageDocente"
            : (user.credencial == 3 ? "/homePageAlumno" : "/homePageDocente");
        Navigator.of(context).pushNamed(path);
      }
    }
  }
}
