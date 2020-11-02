import 'package:flutter/material.dart';
import 'package:flutter_dami/DBCibertec.dart';
import 'package:flutter_dami/model/Usuario.dart';
import 'package:flutter_dami/services/login_response.dart';

void main() => runApp(FlutterDami());

class FlutterDami extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter DAMI",
      theme: ThemeData(primaryColor: Colors.amber),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements LoginCallBack {
  final _formLoginKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _usuario, _password;
  BuildContext _ctx;

  LoginResponse _response;

  _LoginPageState() {
    _response = new LoginResponse(this);
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = new RaisedButton(
      onPressed: _submit(),
    );
    return Scaffold(
      appBar: AppBar(title: Text("f")),
      body: Form(
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
            ElevatedButton(
              onPressed: () {
                if (_formLoginKey.currentState.validate()) {
                  _submit();
                }
              },
              child: Text("Enviar"),
            ),
          ],
        ),
      ),
    );
  }

  LoginResponse _response;
  bool _isLoading = false;

  void _submit() {
    final form = _formLoginKey.currentState;
    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _response.doLogin(_usuario, _password);
      });
    }
  }

  listar(BuildContext context) {
    /*
    return FutureBuilder(
      future: db.getAllUsuario(),
      builder: (BuildContext context, AsyncSnapshot<List<Usuario>> snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: <Widget>[
              for (Usuario usuario in snapshot.data)
                ListTile(
                  title: Text(usuario.name),
                )
            ],
          );
        } else {
          return Center(
            child: Text("cargando"),
          );
        }
      },
    );*/
  }

  addUsuario() {
    /*
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(icon: Icon(Icons.ac_unit)),
                onSubmitted: (text) {
                  setState(() {
                    Usuario u = new Usuario(text);
                    db.insert(u);
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });*/
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
  }

  @override
  void onLoginSuccess(Usuario usuario) {
    // TODO: implement onLoginSuccess
  }
}
