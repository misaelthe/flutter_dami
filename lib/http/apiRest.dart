import 'package:flutter_dami/services/mainService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dami/model/Usuario.dart';

class ApiRest {
  MainService service = new MainService();

  Future<Usuario> getUsuario(String usuario, String password) async {
    Usuario u = await service.getUsuarioBy(usuario, password);
    if (u != null) {
      return u;
    } else {
      var response = await http.get(
          'https://cibertec-schoolar.herokuapp.com/rest/getUsuario?usuario=' +
              usuario +
              '&password=' +
              password);
      if (response.statusCode == 200) {
        var json = await jsonDecode(response.body);
        Usuario u = Usuario.fromJson(json);
        await service.insertUsuario(u);
        return u;
      } else {
        return null;
      }
    }
  }
}
