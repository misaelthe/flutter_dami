import 'package:flutter_dami/DBCibertec.dart';
import 'package:flutter_dami/model/Usuario.dart';

import 'DBCibertec.dart';

class LoginCtrl {
  DBCibertec con = new DBCibertec();

  Future<Usuario> getLogin(String usuario, String password) async {
    var dbCibertec = await con.database;
    Usuario u = new Usuario();
    u.credencial = 1;
    u.idusuario = 1;
    u.usuario = "123";
    u.password = "123";
    insertUsuario(u);
    var res = await dbCibertec.rawQuery(
        "SELECT * FROM usuario u WHERE u.usuario = '$usuario' and password = '$password'");
    if (res.length > 0) {
      return new Usuario.fromMap(res.first);
    }
    return null;
  }

  Future<int> insertUsuario(Usuario usuario) async {
    var dbCibertec = await con.database;
    int res = await dbCibertec.insert(
      "usuario",
      usuario.toMap(),
    );
    return res;
  }

  Future<List<Usuario>> getAllUser() async {
    var dbCibertec = await con.database;
    var res = await dbCibertec.query("usuario");
    List<Usuario> list =
        res.isNotEmpty ? res.map((c) => Usuario.fromMap(c)).toList() : null;
    return list;
  }
}
