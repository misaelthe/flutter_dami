import 'package:flutter/material.dart';
import 'package:flutter_dami/controller/LoginCtrlr.dart';
import 'package:flutter_dami/widgets/header_cibertec.dart';

class DocenteHomePage extends StatelessWidget {
  final LoginCtrl loginCtrl = new LoginCtrl();
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
        padding: const EdgeInsets.only(top: 50, bottom: 20),
        child: HeaderCibertecWidget());

    Widget titleSections = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            /*1*/
            child: Column(
              children: [
                /*2*/

                Text(
                  'Seleccione una herramienta de su preferencia',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          /*3*/
        ],
      ),
    );

    Widget buttonSection = Container(
        padding: EdgeInsets.all(32),
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/escritura.png"),
                      width: 120,
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Text('Asistencia')
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/mensaje-recibido.png"),
                      width: 120,
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Text('Mensajes')
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/comunicacion.png',
                      height: 70.0,
                      width: 70.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Text('Social')
                  ],
                ),
              ),
            ],
          )
        ]));

    Widget buttonSections = Container(
        padding: EdgeInsets.only(top: 1),
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/adjuntar-archivo.png',
                      height: 70.0,
                      width: 70.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Text('Eventos')
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/usuario.png',
                      height: 70.0,
                      width: 70.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Text('Perfil')
                  ],
                ),
              ),
            ],
          )
        ]));

    return MaterialApp(
        title: 'Flutter layout demo',
        home: Scaffold(
            drawer: Drawer(
              child: ListView(padding: EdgeInsets.zero, children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text(
                    'Bienvenido',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Registrar Notas'),
                ),
                ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('Profile'),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    iraPageAlumno(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Sign Out'),
                  onTap: () {
                    signOutDocente(context);
                  },
                ),
              ]),
            ),
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Padding(
                padding: const EdgeInsets.only(left: 70),
                child: Text(
                  'Cibertec',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Verdana",
                      fontWeight: FontWeight.w900,
                      fontSize: 30),
                ),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.search),
                ),
              ],
            ),
            body: Column(
              children: [
                titleSection,
                titleSections,
                buttonSection,
                buttonSections,
              ],
            )));
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 0),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  signOutDocente(BuildContext context) async {
    loginCtrl.signOut();
    Navigator.of(context).pushNamed("/login");
  }

  iraPageAlumno(BuildContext context) async {
    Navigator.of(context).pushNamed("/homePageAlumno");
  }
}
