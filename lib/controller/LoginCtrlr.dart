import 'package:flutter/material.dart';
import 'package:flutter_dami/db/DBCibertec.dart';
import 'package:flutter_dami/model/Usuario.dart';
import 'package:flutter_dami/services/usuario_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/DBCibertec.dart';

class LoginCtrl {
  DBCibertec con = new DBCibertec();
  UsuarioService serUsuario = new UsuarioService();
  Usuario _usuario;

  login(String usuario, String password) async {
    await serUsuario
        .getUsuarioBy(usuario, password)
        .then((value) => _usuario = value);
    return _usuario;
  }

  signOut(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isLoggedIn", false);
    preferences.setInt("idusuario", null);
    preferences.setInt("credencial", null);
    Navigator.pushNamedAndRemoveUntil(context, "/login", (_) => false);
  }
}
