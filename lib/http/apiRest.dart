import 'package:flutter_dami/model/Alumno.dart';
import 'package:flutter_dami/model/Alumno_Clase.dart';
import 'package:flutter_dami/model/Clase.dart';
import 'package:flutter_dami/model/Curso.dart';
import 'package:flutter_dami/model/Docente.dart';
import 'package:flutter_dami/model/Nota.dart';
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
      await service.deleteDB();
      u = await _getUsuario(usuario, password);
      return u;
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
      print("entro con la credencial docente");
      Docente d = await getDocenteByUsuario(u);
      await getCursosDictadosByDocente(d);
      await getClasesDictadasByDocente(d);
      await getAlumnosClaseByDocente(d);
      await getAlumnosByDocente(d);
      await getNotasByDocente(d);
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

  getCursosDictadosByDocente(Docente d) async {
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
        print("Error en el getCursosByDocente");
        print(e);
      }
    } else {
      print("No se obtuvo respuesta de los cursos del docente");
    }
  }

  getClasesDictadasByDocente(Docente d) async {
    var response = await http.get(
        'https://cibertec-schoolar.herokuapp.com/rest/getClaseXDocente?iddocente=' +
            d.iddocente.toString());
    if (response.statusCode == 200) {
      try {
        List json = await jsonDecode(response.body);
        List<Clase> arCla = json.map((e) => new Clase.fromJson(e)).toList();
        for (Clase c in arCla) {
          await service.insertClase(c);
        }
        print("se insertaron las clases del docente");
      } on Exception catch (e) {
        print("error en getClasesByDocente");
        print(e);
      }
    } else {
      print("No se obtuvo respuesta de los clases del docente");
    }
  }

  Future<List<Alumno_Clase>> getAlumnosClaseByDocente(Docente d) async {
    var response = await http.get(
        'https://cibertec-schoolar.herokuapp.com/rest/getAlumnoClaseXDocente?iddocente=' +
            d.iddocente.toString());
    if (response.statusCode == 200) {
      try {
        List json = await jsonDecode(response.body);
        List<Alumno_Clase> tem =
            json.map((e) => new Alumno_Clase.fromJson(e)).toList();
        for (Alumno_Clase a in tem) {
          await service.insertAlumno_Clase(a);
        }
        print("se inserto el alumnoclase");
      } on Exception catch (e) {
        print("error en Alumno_Clase");
        print(e);
      }
    } else {
      print("No se obtuvo respuesta de los alumnos por clase");
    }
  }

  getAlumnosByDocente(Docente d) async {
    var response = await http.get(
        'https://cibertec-schoolar.herokuapp.com/rest/getAlumnosXDocente?iddocente=' +
            d.iddocente.toString());
    if (response.statusCode == 200) {
      try {
        service.getAllAlumno();
        List json = await jsonDecode(response.body);
        List<Alumno> tem = json.map((e) => new Alumno.fromJson(e)).toList();
        print("despues del array de alumnos");
        for (Alumno a in tem) {
          await service.insertAlumno(a);
        }
      } on Exception catch (e) {
        print(e);
      }
    } else {
      print("No se obtuvo respuesta de los alumnos por clase");
    }
  }

  getNotasByDocente(Docente d) async {
    var response = await http.get(
        'https://cibertec-schoolar.herokuapp.com/rest/getNotasXDocente?iddocente=' +
            d.iddocente.toString());
    if (response.statusCode == 200) {
      try {
        List json = await jsonDecode(response.body);
        print(" ersta entrando getNotaByClaseByAlumno");
        List<Nota> tem = json.map((e) => new Nota.fromJson(e)).toList();
        for (Nota n in tem) {
          await service.insertNota(n);
        }
        print(" insertado getNotaByClaseByAlumno");
      } on Exception catch (e) {
        print(" error en getNotaByClaseByAlumno");
        print(e);
      }
    } else {
      print("No se obtuvo respuesta del alumno");
    }
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

///////////////////////////////METODOS DE AMBOS

}
