import 'package:flutter_dami/model/Alumno.dart';
import 'package:flutter_dami/services/mainService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dami/model/Usuario.dart';

class ApiRest {
  MainService service = new MainService();

  Future<Usuario> getUsuario(String usuario, String password) async {
    Usuario u = await service.getUsuarioBy(usuario, password);
    if (u != null) {
      //await getData(u);
      return u;
    } else {
      var response = await http.get(
          'https://cibertec-schoolar.herokuapp.com/rest/getUsuario?usuario=' +
              usuario +
              '&password=' +
              password);
      if (response.statusCode == 200) {
        try {
          var json = await jsonDecode(response.body);
          Usuario u = Usuario.fromJson(json);
          //await getData(u);
          await service.insertUsuario(u);
          return u;
        } on Exception catch (_) {
          return null;
        }
      } else {
        return null;
      }
    }
  }

  getData(Usuario u) async {
    var response;
    //SI ES PROFESOR ENTRA AQUI
    if (u.credencial == 2) {
      /*response = await http.get(
          'https://cibertec-schoolar.herokuapp.com/rest/getCurso?usuario=' +
              usuario +
              '&password=' +
              password);*/
    }
    //SI ES ALUMNO ENTRA AQUI
    else if (u.credencial == 3) {
      response = await http.get(
          'https://cibertec-schoolar.herokuapp.com/rest/getAlumno?idusuario=' +
              u.idusuario.toString());
      if (response.statusCode == 200) {
        var json = await jsonDecode(response.body);
        Alumno a = Alumno.fromJson(json);
        await service.insertAlumno(a);
        return u;
      } else {
        return null;
      }
    }
  }
}
