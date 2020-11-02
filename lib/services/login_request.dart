import 'dart:async';
import 'package:flutter_dami/model/Usuario.dart';
import 'package:flutter_dami/controller/LoginCtrlr.dart';

class LoginRequest {
  LoginCtrl con = new LoginCtrl();
  Future<Usuario> getLogin(String usuario, String password) {
    var result = con.getUsuario(usuario, password);
    return result;
  }
}
