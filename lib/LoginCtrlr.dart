import 'package:flutter_dami/DBCibertec.dart';
import 'package:flutter_dami/model/Usuario.dart';

import 'DBCibertec.dart';

class LoginCtrl {
  DBCibertec con = new DBCibertec();

  Future<int> insertUsuario(Usuario usuario) async {
    var dbCibertec = await con.database;
    int res = await dbCibertec.insert(
      "usuario",
      usuario.toMap(),
    );
    return res;
  }

  Future<Usuario> getUsuario(String usuario, String password) async {
    var dbClient = await con.database;
    var res = await dbClient.rawQuery(
        "SELECT * FROM user WHERE username = '$usuario' and password = '$password'");
    if (res.length > 0) {
      return new Usuario.fromMap(res.first);
    }
    return null;
  }

  Future<List<Usuario>> getAllUsuario() async {
    var dbCibertec = await con.database;
    var res = await dbCibertec.query("usuario");
    List<Usuario> list =
        res.isNotEmpty ? res.map((c) => Usuario.fromMap(c)).toList() : null;
    return list;
  }
}
