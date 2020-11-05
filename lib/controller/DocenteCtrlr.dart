import 'package:flutter_dami/db/DBCibertec.dart';
import 'package:flutter_dami/model/Usuario.dart';

import '../db/DBCibertec.dart';

class DocenteCtrl {
  DBCibertec con = new DBCibertec();

  Future<List<Usuario>> getCoursesForTeacher(int idprofesor) async {
    var dbCibertec = await con.database;
    var res = await dbCibertec
        .rawQuery("select * from curso where idprofesor='$idprofesor'");
    List<Usuario> list =
        res.isNotEmpty ? res.map((c) => Usuario.fromMap(c)).toList() : null;
    return list;
  }
}
