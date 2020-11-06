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
    await db.execute(
        "CREATE TABLE administrador(idadministrador INTEGER primary key,nombre TEXT,idusuario INTEGER)");
    await db
        .execute("CREATE TABLE turno(idturno INTEGER primary key,turno TEXT)");
    await db.execute(
        "CREATE TABLE carrera(idcarrera INTEGER primary key,nombre TEXT)");
    await db.execute(
        "CREATE TABLE curso(idcurso INTEGER primary key,nombre TEXT,idcarrera INTEGER,ciclo INTEGER)");
    await db.execute(
        "CREATE TABLE seccion(idseccion INTEGER primary key,codigo TEXT,idcarrera INTEGER,ciclo INTEGER)");
    await db.execute(
        "CREATE TABLE clase(idclase INTEGER primary key,idseccion TEXT,idcurso INTEGER,iddocente INTEGER,alum_ins INTEGER)");
    await db.execute(
        "CREATE TABLE alumno_clase(idalumno_clase INTEGER primary key,idalumno TEXT,idclase INTEGER)");
    await db.execute(
        "CREATE TABLE nota(idnota INTEGER primary key,idclase TEXT,idalumno INTEGER,e1 INTEGER,e2 INTEGER,ep INTEGER,e3 INTEGER,ef INTEGER,promedio INTEGER)");
    await db.execute(
        "CREATE TABLE matricula(idmatricula INTEGER primary key,idalumno INTEGER,periodo TEXT,ciclo INTEGER,year INTEGER,idcarrera INTEGER,idturno TEXT)");
    _insert(db);
  }

  void _insert(Database db) async {
    await db.rawInsert(
        "INSERT INTO usuario(idusuario,usuario,password,credencial) values (1,'admin','admin',1)");
    await db.rawInsert(
        "INSERT INTO usuario(idusuario,usuario,password,credencial) values (2,'misa','misa',2)");
    await db.rawInsert(
        "INSERT INTO usuario(idusuario,usuario,password,credencial) values (3,'kath','kath',2)");
    await db.rawInsert(
        "INSERT INTO usuario(idusuario,usuario,password,credencial) values (4,'suyin','suyin',3)");
  }
}
