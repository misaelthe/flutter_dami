import 'package:flutter_dami/db/DBCibertec.dart';
import 'package:flutter_dami/http/apiRest.dart';
import 'package:flutter_dami/model/Curso.dart';
import 'package:flutter_dami/model/Docente.dart';
import 'package:flutter_dami/model/Nota.dart';
import 'package:flutter_dami/services/mainService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/DBCibertec.dart';

class DocenteCtrl {
  DBCibertec con = new DBCibertec();
  MainService service = new MainService();
  ApiRest rest = new ApiRest();

  Future<int> getIdDocente() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int idusuario = preferences.getInt("idusuario");
    Docente d = await service.getDocenteBy(idusuario);
    return d.iddocente;
  }

  getClasesByDocente(int iddocente) async {
    return await service.getClasesByDocente(iddocente);
  }

  getAlumnosByClase(int idclase) async {
    return await service.getAlumnosByClase(idclase);
  }

  getSeccionByClase(int idclase) async {
    return await service.getSeccionByClase(idclase);
  }

  Future<Nota> getNotaByClaseByAlumno(int idclase, int idalumno) async {
    Nota tem = await service.getNotaByClaseByAlumno(idclase, idalumno);
    return tem;
  }

  Future<Nota> getNotaBy(int idnota) async {
    Nota tem = await service.getNotaBy(idnota);
    return tem;
  }

  Future<Curso> getCursoBy(int idcurso) async {
    Curso tem = await service.getCursoBy(idcurso);
    return tem;
  }

  void bajarCambios() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int idusuario = preferences.getInt("idusuario");
    Docente d = await service.getDocenteBy(idusuario);
    ApiRest rest = new ApiRest();
    rest.bajarCambiosByDocente(d);
  }

  registrarNota(
      int idnota, int e1, int e2, int ep, int e3, int ef, int promedio) async {
    Nota n = await getNotaBy(idnota);
    n.e1 = e1;
    n.e2 = e2;
    n.ep = ep;
    n.e3 = e3;
    n.ef = ef;
    n.promedio = promedio;
    service.actualizarNota(n);
    rest.actualizarNota(n);
  }
}
