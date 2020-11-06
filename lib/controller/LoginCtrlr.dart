import 'package:flutter_dami/db/DBCibertec.dart';
import 'package:flutter_dami/services/usuario_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/DBCibertec.dart';

class LoginCtrl {
  DBCibertec con = new DBCibertec();
  UsuarioService serUsuario = new UsuarioService();

  login(String usuario, String password) async {
    int idusuario;
    await serUsuario
        .getUsuarioBy(usuario, password)
        .then((usuario) => idusuario = usuario.idusuario)
        .catchError((onError) => onError.toString());
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("isLogged", 1);
    preferences.setInt("idusuario", idusuario);
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("isLogged", 0);
    preferences.setInt("idusuario", null);
  }
}
