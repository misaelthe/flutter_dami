import 'package:flutter/material.dart';
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
    preferences.setBool("isLoggedIn", true);
    preferences.setInt("idusuario", idusuario);
  }

  signOut(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isLoggedIn", false);
    preferences.setInt("idusuario", null);
    Navigator.pushNamedAndRemoveUntil(context, "/login", (_) => false);
  }
}
