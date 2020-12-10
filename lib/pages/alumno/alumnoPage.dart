import 'package:flutter/material.dart';
import 'package:flutter_dami/controller/AlumnoCtrl.dart';
import 'package:flutter_dami/controller/LoginCtrlr.dart';
import 'package:flutter_dami/widgets/header_cibertec.dart';

class AlumnoHomePage extends StatelessWidget {
  final LoginCtrl loginCtrl = new LoginCtrl();
  final AlumnoCtrl alumnoCtrl = new AlumnoCtrl();
  final styleOpciones = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.only(top: 50, bottom: 20),
      child: HeaderCibertecWidget(),
    );

    Widget titleSections = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              children: [
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
        ],
      ),
    );
//
    Widget buttonSection = Container(
        padding: EdgeInsets.all(32),
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/escritura.png',
                      height: 70.0,
                      width: 70.0,
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
                    Image.asset(
                      'assets/mensaje-recibido.png',
                      height: 70.0,
                      width: 70.0,
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
                    'Bienvenido Alumno',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    size: 40,
                  ),
                  title: Text(
                    'Mi Perfil',
                    style: styleOpciones,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.import_contacts,
                    size: 40,
                  ),
                  title: Text(
                    'Ver Notas',
                    style: styleOpciones,
                  ),
                  onTap: () => {goPageListClasesByAlumno(context)},
                ),
                ListTile(
                  leading: Icon(
                    Icons.cloud_download_rounded,
                    size: 40,
                  ),
                  title: Text(
                    'Bajar Cambios',
                    style: styleOpciones,
                  ),
                  onTap: () => {bajarCambios(context)},
                ),
                ListTile(
                  leading: Icon(
                    Icons.alarm_sharp,
                    size: 40,
                  ),
                  title: Text(
                    'Horario',
                    style: styleOpciones,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    size: 40,
                  ),
                  title: Text(
                    'Configuracion',
                    style: styleOpciones,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    size: 40,
                  ),
                  title: Text(
                    'Sign Out',
                    style: styleOpciones,
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Sign Out"),
                            content: Text("¿Seguro que desea salir?"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("Ok"),
                                onPressed: () {
                                  signOut(context);
                                },
                              ),
                              FlatButton(
                                child: Text("Cancelar"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                            elevation: 24.0,
                          );
                        });
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

  /*Column _buildButtonColumn(Color color, IconData icon, String label) {
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
  }*/

  signOut(BuildContext context) async {
    loginCtrl.signOut(context);
  }

  goPageListClasesByAlumno(BuildContext context) async {
    Navigator.of(context).pushNamed("/pageClasesAlumno");
  }

  bajarCambios(BuildContext context) async {
    alumnoCtrl.bajarCambios();
  }
}
