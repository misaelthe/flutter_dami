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
      await service.deleteDB();
      print("existe la abi" + u.idusuario.toString());
      await getData(u);
      return u;
    } else {
      await service.deleteDB();
      _getUsuario(usuario, password);
    }
  }

  _getUsuario(String usuario, String password) async {
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

  getData(Usuario u) async {
    //SI ES PROFESOR ENTRA AQUI
    if (u.credencial == 2) {
      Docente d = await getDocenteByUsuario(u);
      await getCursosByDocente(d);
    }
    //SI ES ALUMNO ENTRA AQUI
    else if (u.credencial == 3) {
      Alumno a = await getAlumnoByUsuario(u);
    }
  }

///////////////////////////////METODOS PARA EL DOCENTE LOGUEADO
  Future<Docente> getDocenteByUsuario(Usuario u) async {
    Docente d;
    var response = await http.get(
        'https://cibertec-schoolar.herokuapp.com/rest/getDocente?idusuario=' +
            u.idusuario.toString());
    if (response.statusCode == 200) {
      try {
        var json = await jsonDecode(response.body);
        d = Docente.fromJson(json);
        await service.insertDocente(d);
        print("se agrego al docente");
        return d;
      } on Exception catch (e) {
        print(e);
      }
    } else {
      print("No hubo respuesta al obtener el docente");
      return d;
    }
  }

  getCursosByDocente(Docente d) async {
    var response = await http.get(
        'https://cibertec-schoolar.herokuapp.com/rest/getCursoXDocente?iddocente=' +
            d.iddocente.toString());
    if (response.statusCode == 200) {
      try {
        List json = await jsonDecode(response.body);
        List<Curso> arCur = json.map((e) => new Curso.fromJson(e)).toList();
        print("despues del array de cursos");
        for (Curso c in arCur) {
          await service.insertCurso(c);
        }
      } on Exception catch (e) {
        print(e);
      }
    } else {
      print("No se obtuvo respuesta de los cursos del docente");
    }
  }

  getClasesByDocente(Docente d) async {
    var response = await http.get(
        'https://cibertec-schoolar.herokuapp.com/rest/getClaseXDocente?iddocente=' +
            d.iddocente.toString());
    if (response.statusCode == 200) {
      try {
        List json = await jsonDecode(response.body);
        List<Clase> arCla = json.map((e) => new Clase.fromJson(e)).toList();
        print("despues del array de cursos");
        for (Clase c in arCla) {
          await service.insertClase(c);
        }
      } on Exception catch (e) {
        print(e);
      }
    } else {
      print("No se obtuvo respuesta de los cursos del docente");
    }
  }

  getAlumnoByClase(Clase c) async {
    /*var response = await http.get(
        'https://cibertec-schoolar.herokuapp.com/rest/getClaseXDocente?iddocente=' +
            d.iddocente.toString());
    if (response.statusCode == 200) {
      try {
        List json = await jsonDecode(response.body);
        List<Alumno> arCla = json.map((e) => new Clase.fromJson(e)).toList();
        print("despues del array de cursos");
        for (Clase c in arCla) {
          await service.insertClase(c);
        }
      } on Exception catch (e) {
        print(e);
      }
    } else {
      print("No se obtuvo respuesta de los cursos del docente");
    }*/
  }

///////////////////////////////METODOS PARA EL ALUMNO LOGUEADO
  getAlumnoByUsuario(Usuario u) async {
    var response = await http.get(
        'https://cibertec-schoolar.herokuapp.com/rest/getAlumno?idusuario=' +
            u.idusuario.toString());
    if (response.statusCode == 200) {
      try {
        var json = await jsonDecode(response.body);
        Alumno a = Alumno.fromJson(json);
        await service.insertAlumno(a);
        return u;
      } on Exception catch (e) {
        print(e);
      }
    } else {
      print("No se obtuvo respuesta del alumno");
    }
  }
}
