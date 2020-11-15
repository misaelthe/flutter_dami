import 'package:flutter_dami/db/DBCibertec.dart';
import 'package:flutter_dami/model/Alumno.dart';
import 'package:flutter_dami/model/Clase.dart';
import 'package:flutter_dami/model/Curso.dart';
import 'package:flutter_dami/model/Docente.dart';
import 'package:flutter_dami/model/Nota.dart';
import 'package:flutter_dami/services/mainService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/DBCibertec.dart';

class DocenteCtrl {
  DBCibertec con = new DBCibertec();
  MainService service = new MainService();

  Future<int> getIdDocente() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int idusuario = preferences.getInt("idusuario");
    Docente d = await service.getDocenteBy(idusuario);
    return d.iddocente;
  }

  Future<List<Clase>> getClasesByDocente(int iddocente) async {
    List<Clase> tem = await service.getClasesByProfesor(iddocente);
    return tem;
  }

  Future<List<Alumno>> getAlumnosByClase(int idclase) async {
    List<Alumno> tem = await service.getAlumnosByClase(idclase);
    return tem;
  }

  Future<Nota> getNotaByClaseByAlumno(int idclase, int idalumno) async {
    Nota tem = await service.getNotaByClaseByAlumno(idclase, idalumno);
    return tem;
  }

  Future<String> getCursoByClase(int idclase) async {
    Curso tem = await service.getCursoByClase(idclase);
    return tem.nombre;
  }
}
