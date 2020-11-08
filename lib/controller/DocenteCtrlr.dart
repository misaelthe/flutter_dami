import 'package:flutter_dami/db/DBCibertec.dart';
import 'package:flutter_dami/model/Alumno.dart';
import 'package:flutter_dami/model/Usuario.dart';

import '../db/DBCibertec.dart';

class DocenteCtrl {
  DBCibertec con = new DBCibertec();
  var dbCibertec;

  Future<List<Usuario>> getCoursesForTeacher(int idprofesor) async {
    dbCibertec = await con.database;
    var res = await dbCibertec
        .rawQuery("select * from curso where idprofesor='$idprofesor'");
    List<Usuario> list =
        res.isNotEmpty ? res.map((c) => Usuario.fromMap(c)).toList() : null;
    return list;
  }

  Future<List<Alumno>> getAlumno() async {
    dbCibertec = await con.database;
    var res = await dbCibertec.rawQuery(
        "select a.* from alumno a,alumno_clase ac where a.idalumno=ac.idalumno and ac.idclase=");
    List<Alumno> list =
        res.isNotEmpty ? res.map((c) => Alumno.fromMap(c)).toList() : null;
    return list;
  }
}
