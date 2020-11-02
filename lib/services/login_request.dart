import 'dart:async';
import 'package:flutter_dami/model/Usuario.dart';
import 'package:flutter_dami/LoginCtrlr.dart';

class LoginRequest {
  LoginCtrl con = new LoginCtrl();
  Future<Usuario> getLogin(String usuario, String password) {
    print('en el request' + usuario + ' ' + password);
    var result = con.getUsuario(usuario, password);
    return result;
  }
}
