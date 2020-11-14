import 'package:flutter_dami/model/Alumno.dart';
import 'package:flutter_dami/model/Clase.dart';
import 'package:flutter_dami/model/Curso.dart';
import 'package:flutter_dami/model/Docente.dart';
import 'package:flutter_dami/services/mainService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dami/model/Usuario.dart';

class ApiRest {
  MainService service = new MainService();

  Future<Usuario> getUsuario(String usuario, String password) async {
    Usuario u = await service.getUsuarioBy(usuario, password);
    if (u != null) {
      service.deleteDB();
      print("existe la abi" + u.idusuario.toString());
      await getData(u);
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
          await getData(u);
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
    print("antes de pedir credenciales");
    if (u.credencial == 2) {
      Docente d;
      response = await http.get(
          'https://cibertec-schoolar.herokuapp.com/rest/getDocente?idusuario=' +
              u.idusuario.toString());
      print("antes de response sttausest");
      if (response.statusCode == 200) {
        try {
          print("dentrodel if");
          var json = await jsonDecode(response.body);
          print("despues de la declaracion del json");
          d = Docente.fromJson(json);
          await service.insertDocente(d);
          print(
              "al mometo d extrae r docente del rest" + d.iddocente.toString());
        } on Exception catch (e) {
          print(e);
        }
        response = await http.get(
            'https://cibertec-schoolar.herokuapp.com/rest/getCursoXDocente?iddocente=' +
                d.iddocente.toString());
        var json = await jsonDecode(response.body);
        Curso cur = Curso.fromJson(json);
        await service.insertCurso(cur);
        /*response = await http.get(
            'https://cibertec-schoolar.herokuapp.com/rest/getClaseXDocente?iddocente=' +
                d.iddocente.toString());
        json = await jsonDecode(response.body);
        Clase c = Clase.fromJson(json);
        await service.insertClase(c);*/
      } else {}
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
