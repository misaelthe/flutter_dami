import 'package:flutter_dami/db/DBCibertec.dart';
import 'package:flutter_dami/http/apiRest.dart';
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

  getCursoBy(int idcurso) async {
    return await service.getCursoBy(idcurso);
  }

  getSeccionByClase(int idclase) async {
    return await service.getSeccionByClase(idclase);
  }

  void bajarCambios() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int idusuario = preferences.getInt("idusuario");
    Alumno a = await service.getAlumnoBy(idusuario);
    ApiRest rest = new ApiRest();
    rest.bajarCambiosByAlumno(a);
  }

  Future<Nota> getNotaByClase(int idclase) async {
    return await service.getNotaByClase(idclase);
  }
}
