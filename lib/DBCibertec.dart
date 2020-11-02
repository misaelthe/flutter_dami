import 'package:sqflite/sqflite.dart';
import "dart:async";
import 'package:path/path.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'model/Usuario.dart';

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
    return await openDatabase(
      join(await getDatabasesPath(), databaseName),
      version: 1,
      onCreate: (db, version) async {
        return db.execute(
            "CREATE TABLE usuario(idusuario INTEGER primary key,usuario TEXT,password TEXT,credencial INTEGER)");
      },
    );
  }
}
