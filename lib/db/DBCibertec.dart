import 'package:sqflite/sqflite.dart';
import "dart:async";
import 'package:path/path.dart';

class DBCibertec {
  static const databaseName = 'cibertec.db';
  static final DBCibertec instance = DBCibertec.internal();
  factory DBCibertec() => instance;
  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      return await initializeDatabase();
    }
    return _database;
  }

  DBCibertec.internal();

  initializeDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), databaseName),
        version: 1, onCreate: (db, version) => _createDb(db, 1));
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE usuario(idusuario INTEGER primary key,usuario TEXT,password TEXT,credencial INTEGER)");
    await db.execute(
        "CREATE TABLE docente(iddocente INTEGER primary key,nombre TEXT,dni TEXT,idusuario INTEGER,idcarrera INTEGER,telefono TEXT,correo TEXT,direccion TEXT,fecnac TEXT)");
    await db.execute(
        "CREATE TABLE alumno(idalumno INTEGER primary key,nombre TEXT,dni TEXT,idusuario INTEGER,telefono TEXT,correo TEXT,direccion TEXT,fecnac TEXT)");
    _insert(db);
  }

  void _insert(Database db) async {
    await db.rawInsert(
        "INSERT INTO usuario(idusuario,usuario,password,credencial) values (1,'abc','abc',1)");
    await db.rawInsert(
        "INSERT INTO usuario(idusuario,usuario,password,credencial) values (2,'misa','misa',2)");
  //  await db.rawInsert(
  //      "INSERT INTO alumno(idusuario,usuario,password,credencial) values (1,'kath','kath',1)");
  
  
  
  }
}
