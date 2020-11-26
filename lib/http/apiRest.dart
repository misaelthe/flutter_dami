import 'package:flutter_dami/model/Alumno.dart';
import 'package:flutter_dami/model/Alumno_Clase.dart';
import 'package:flutter_dami/model/Clase.dart';
import 'package:flutter_dami/model/Curso.dart';
import 'package:flutter_dami/model/Docente.dart';
import 'package:flutter_dami/model/Nota.dart';
import 'package:flutter_dami/model/Seccion.dart';
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
      Docente d = await getDocenteByUsuario(u);
      await getSeccionesByDocente(d);
      await getCursosDictadosByDocente(d);
      await getClasesDictadasByDocente(d);
      await getAlumnosClaseByDocente(d);
      await getAlumnosByDocente(d);
      await getNotasByDocente(d);
    }
    //SI ES ALUMNO ENTRA AQUI
    else if (u.credencial == 3) {
      Alumno a = await getAlumnoByUsuario(u);
      await getSeccionesByAlumno(a);
      await getCursosDictadosByAlumno(a);
      await getClasesDictadasByAlumno(a);
      await getAlumnosClaseByAlumno(a);
      await getNotasByAlumno(a);
    }
  }

///////////////////////////////METODOS PARA EL DOCENTE LOGUEADO
  Future<Docente> getDocenteByUsuario(Usuario u) async {
    var response = await http.get(
        'https://cibertec-schoolar.herokuapp.com/rest/getDocente?idusuario=' +
            u.idusuario.toString());
    if (response.statusCode == 200) {
      try {
        var json = await jsonDecode(response.body);
        Docente d = Docente.fromJson(json);
        await service.insertDocente(d);
        return d;
      } on Exception catch (e) {
        print(e);
        return null;
      }
    } else {
      print("No hubo respuesta al obtener el docente");
      return null;
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
      } on Exception catch (e) {
        print(e);
      }
    } else {
      print("No se obtuvo respuesta de los clases del docente");
    }
  }

  getAlumnosClaseByDocente(Docente d) async {
    var response = await http.get(
        'https://cibertec-schoolar.herokuapp.com/rest/getAlumnoClaseXDocente?iddocente=' +
            d.iddocente.toString());
    if (response.statusCode == 200) {
      try {
        List json = await jsonDecode(response.body);
        List<Alumno_Clase> tem =
            json.map((e) => new Alumno_Clase.fromJson(e)).toList();
        for (Alumno_Clase a in tem) {
          await service.insertAlumnoClase(a);
        }
      } on Exception catch (e) {
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
        List<Nota> tem = json.map((e) => new Nota.fromJson(e)).toList();
        for (Nota n in tem) {
          await service.registrarNota(n);
        }
      } on Exception catch (e) {
        print(e);
      }
    } else {
      print("No se obtuvo respuesta del alumno");
    }
  }

  getSeccionesByDocente(Docente d) async {
    var response = await http.get(
        'https://cibertec-schoolar.herokuapp.com/rest/getSeccionesXDocente?iddocente=' +
            d.iddocente.toString());
    if (response.statusCode == 200) {
      try {
        List json = await jsonDecode(response.body);
        List<Seccion> tem = json.map((e) => new Seccion.fromJson(e)).toList();
        for (Seccion s in tem) {
          await service.insertSeccion(s);
        }
      } on Exception catch (e) {
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
        return a;
      } on Exception catch (e) {
        print(e);
      }
    } else {
      print("No se obtuvo respuesta del alumno");
    }
  }

  getSeccionesByAlumno(Alumno a) async {
    var response = await http.get(
        'https://cibertec-schoolar.herokuapp.com/rest/getSeccionesXAlumno?idalumno=' +
            a.idalumno.toString());
    if (response.statusCode == 200) {
      try {
        List json = await jsonDecode(response.body);
        List<Seccion> tem = json.map((e) => new Seccion.fromJson(e)).toList();
        for (Seccion s in tem) {
          await service.insertSeccion(s);
        }
      } on Exception catch (e) {
        print(e);
      }
    } else {
      print("No se obtuvo respuesta del alumno");
    }
  }

  getCursosDictadosByAlumno(Alumno a) async {
    var response = await http.get(
        'https://cibertec-schoolar.herokuapp.com/rest/getCursoXAlumno?idalumno=' +
            a.idalumno.toString());
    if (response.statusCode == 200) {
      try {
        List json = await jsonDecode(response.body);
        List<Curso> arCur = json.map((e) => new Curso.fromJson(e)).toList();
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

  getClasesDictadasByAlumno(Alumno a) async {
    var response = await http.get(
        'https://cibertec-schoolar.herokuapp.com/rest/getClaseXAlumno?idalumno=' +
            a.idalumno.toString());
    if (response.statusCode == 200) {
      try {
        List json = await jsonDecode(response.body);
        List<Clase> arCla = json.map((e) => new Clase.fromJson(e)).toList();
        for (Clase c in arCla) {
          await service.insertClase(c);
        }
      } on Exception catch (e) {
        print(e);
      }
    } else {
      print("No se obtuvo respuesta de los clases del docente");
    }
  }

  getAlumnosClaseByAlumno(Alumno a) async {
    var response = await http.get(
        'https://cibertec-schoolar.herokuapp.com/rest/getAlumnoClaseXAlumno?idalumno=' +
            a.idalumno.toString());
    if (response.statusCode == 200) {
      try {
        List json = await jsonDecode(response.body);
        List<Alumno_Clase> tem =
            json.map((e) => new Alumno_Clase.fromJson(e)).toList();
        for (Alumno_Clase a in tem) {
          await service.insertAlumnoClase(a);
        }
      } on Exception catch (e) {
        print(e);
      }
    } else {
      print("No se obtuvo respuesta de los alumnos por clase");
    }
  }

  getNotasByAlumno(Alumno a) async {
    var response = await http.get(
        'https://cibertec-schoolar.herokuapp.com/rest/getNotasXAlumno?idalumno=' +
            a.idalumno.toString());
    if (response.statusCode == 200) {
      try {
        List json = await jsonDecode(response.body);
        List<Nota> tem = json.map((e) => new Nota.fromJson(e)).toList();
        for (Nota n in tem) {
          await service.registrarNota(n);
        }
      } on Exception catch (e) {
        print(e);
      }
    } else {
      print("No se obtuvo respuesta del alumno");
    }
  }

///////////////////////////////REGISTRAR NOTA
  actualizarNota(Nota nota) async {
    var response = await http.post(
        'https://cibertec-schoolar.herokuapp.com/rest/registrarNota',
        body: nota.toJson(nota));
    if (response.statusCode == 201) {
      print("Se inserto correctamente");
    } else {
      print("No se obtuvo respuesta del alumno");
    }
  }
}
