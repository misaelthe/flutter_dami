import 'package:flutter/material.dart';
import 'package:flutter_dami/DBCibertec.dart';
import 'package:flutter_dami/LoginCtrlr.dart';
import 'package:flutter_dami/home_page.dart';
import 'package:flutter_dami/model/Usuario.dart';
import 'package:flutter_dami/services/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(FlutterDami());

class FlutterDami extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter DAMI",
      theme: ThemeData(primaryColor: Colors.amber),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginPageState extends State<LoginPage> implements LoginCallBack {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  final _formLoginKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _usuario, _password;
  BuildContext _ctx;

  LoginResponse _response;
  bool _isLoading = false;

  _LoginPageState() {
    _response = new LoginResponse(this);
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        _ctx = context;
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
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Usuario'),
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
          appBar: AppBar(title: Text("f")),
          key: scaffoldKey,
          body: formLogin,
        );
        break;
      case LoginStatus.signIn:
        return HomePage();
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  void _submit() {
    final form = _formLoginKey.currentState;
    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        LoginCtrl con = new LoginCtrl();
        con.insertUsuario(new Usuario(2, _usuario, _password, 1));
        print(_usuario + " a sido añadido");
        _response.doLogin(_usuario, _password);
      });
    }
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      // ignore: deprecated_member_use
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  savePref(int value, String user, String pass) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("user", user);
      preferences.setString("pass", pass);
      // ignore: deprecated_member_use
      preferences.commit();
    });
  }

  @override
  void onLoginError(String error) {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(Usuario usuario) {
    if (usuario != null) {
      savePref(1, usuario.usuario, usuario.password);
      _loginStatus = LoginStatus.signIn;
    } else {
      setState(() {
        _isLoading = false;
      });
    }

    //Navigator.of(context).pushNamed("/home");
  }
}
