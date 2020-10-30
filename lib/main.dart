import 'package:flutter/material.dart';
import 'package:flutter_dami/database.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  DBCibertec db = new DBCibertec();
  List<String> usuario = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("f")),
      body: FutureBuilder(
          future: db.initDB(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Usuario>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _listar(context);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _addUsuario(),
        tooltip: "Increment",
        child: Icon(Icons.add),
      ),
    );
  }

  _listar(BuildContext context) {
    return FutureBuilder(
      future: db.getAllUsuario(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ListView(
          children: <Widget>[
            for (Usuario usuario in snapshot.data)
              ListTile(
                title: Text(usuario.name),
              )
          ],
        );
      },
    );
  }

  _addUsuario() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(icon: Icon(Icons.ac_unit)),
                onSubmitted: (text) {
                  setState(() {
                    var u = Usuario(text);
                    db.insert(u);
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
}
