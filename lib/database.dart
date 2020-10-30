import 'package:sqflite/sqflite.dart';
import "dart:async";

class Usuario {
  String name;
  Usuario(this.name);
  Map<String, dynamic> toMap() {
    return {"name": name};
  }

  Usuario.fromMap(Map<String, dynamic> map) {
    name = map["name"];
  }
}

class DBCibertec {
  Database db;
  initDB() async {
    db = await openDatabase('my_db.db', version: 1,
        onCreate: (Database db, int version) {
      db.execute(
          "create table usuario(idusuario Integer primary key,usuario varchar(45),contraseña varchar(45),credencial Integer)");
    });
    print("se esta cargando la bd");
  }

  insert(Usuario usuario) async {
    db.insert("usuario", usuario.toMap());
  }

  Future<List<Usuario>> getAllUsuario() async {
    List<Map<String, dynamic>> result = await db.query("usuario");
    return result.map((map) => Usuario.fromMap(map));
  }
}
