import 'package:flutter_dami/db/DBCibertec.dart';
import 'package:flutter_dami/model/Alumno.dart';
import 'package:flutter_dami/model/Clase.dart';
import 'package:flutter_dami/model/Curso.dart';
import 'package:flutter_dami/model/Docente.dart';
import 'package:flutter_dami/model/Usuario.dart';

class MainService {
  DBCibertec con = new DBCibertec();
  var dbCibertec;

  Future<int> insertUsuario(Usuario usuario) async {
    dbCibertec = await con.database;
    int res = await dbCibertec.insert(
      "usuario",
      usuario.toMap(),
    );
    return res;
  }

  Future<int> insertAlumno(Alumno alumno) async {
    dbCibertec = await con.database;
    int res = await dbCibertec.insert(
      "alumno",
      alumno.toMap(),
    );
    return res;
  }

  Future<int> insertDocente(Docente docente) async {
    dbCibertec = await con.database;
    int res = await dbCibertec.insert(
      "docente",
      docente.toMap(),
    );
    return res;
  }

  Future<int> insertClase(Clase clase) async {
    dbCibertec = await con.database;
    int res = await dbCibertec.insert(
      "clase",
      clase.toMap(),
    );
    return res;
  }

  Future<int> insertCurso(Curso curso) async {
    dbCibertec = await con.database;
    int res = await dbCibertec.insert(
      "curso",
      curso.toMap(),
    );
    return res;
  }

  Future<Usuario> getUsuarioBy(String usuario, String password) async {
    dbCibertec = await con.database;
    var resultado = await dbCibertec.rawQuery(
        "SELECT * FROM usuario u WHERE u.usuario = ? and u.password = ?",
        [usuario, password]);
    if (resultado.length > 0) {
      return new Usuario.fromMap(resultado.first);
    }
    return null;
  }

  Future<List<Usuario>> getAllUsuario() async {
    dbCibertec = await con.database;
    var res = await dbCibertec.query("usuario");
    List<Usuario> list =
        res.isNotEmpty ? res.map((c) => Usuario.fromMap(c)).toList() : null;
    return list;
  }

  void deleteDB() async {
    dbCibertec = await con.database;
    await dbCibertec.delete("usuario");
    await dbCibertec.delete("alumno");
    await dbCibertec.delete("docente");
    print("elimino el suaurio");
  }
}
