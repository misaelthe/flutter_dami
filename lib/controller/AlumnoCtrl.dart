import 'package:flutter_dami/db/DBCibertec.dart';
import 'package:flutter_dami/model/Alumno.dart';
import 'package:flutter_dami/model/Nota.dart';
import 'package:flutter_dami/services/mainService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlumnoCtrl {
  DBCibertec con = new DBCibertec();
  MainService service = new MainService();

  Future<int> getIdAlumno() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int idusuario = preferences.getInt("idusuario");
    Alumno d = await service.getAlumnoBy(idusuario);
    return d.idalumno;
  }

  getClasesByAlumno(int idalumno) async {
    return await service.getClasesByAlumno(idalumno);
  }

  getCursoByClase(int idclase) async {
    return await service.getCursoByClase(idclase);
  }

  Future<Nota> getNotaByClase(int idclase) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int idusuario = preferences.getInt("idusuario");
    Alumno a = await service.getAlumnoBy(idusuario);
    return await service.getNotaByClaseByAlumno(idclase, a.idalumno);
  }
}
