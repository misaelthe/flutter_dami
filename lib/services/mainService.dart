import 'package:flutter_dami/db/DBCibertec.dart';
import 'package:flutter_dami/model/Alumno.dart';
import 'package:flutter_dami/model/Alumno_Clase.dart';
import 'package:flutter_dami/model/Clase.dart';
import 'package:flutter_dami/model/Curso.dart';
import 'package:flutter_dami/model/Docente.dart';
import 'package:flutter_dami/model/Nota.dart';
import 'package:flutter_dami/model/Seccion.dart';
import 'package:flutter_dami/model/Usuario.dart';

class MainService {
  DBCibertec con = new DBCibertec();
  var dbCibertec;

///////////////////////////////////////////////METODOS PARA INSERTAR
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

  Future<int> insertAlumno_Clase(Alumno_Clase al_cla) async {
    dbCibertec = await con.database;
    int res = await dbCibertec.insert(
      "alumno_clase",
      al_cla.toMap(),
    );
    return res;
  }

  Future<int> insertSeccion(Seccion sec) async {
    dbCibertec = await con.database;
    int res = await dbCibertec.insert(
      "seccion",
      sec.toMap(),
    );
    return res;
  }

  Future<int> registrarNota(Nota nota) async {
    dbCibertec = await con.database;
    int res = await dbCibertec.insert(
      "nota",
      nota.toMap(),
    );
    return res;
  }

  Future<int> actualizarNota(Nota nota) async {
    dbCibertec = await con.database;
    int res = await dbCibertec.insert(
      "nota",
      nota.toMap(),
    );
    return res;
  }

///////////////////////////////////////////////METODOS PARA BUSCAR
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

  Future<Docente> getDocenteBy(int idusuario) async {
    dbCibertec = await con.database;
    var res = await dbCibertec
        .rawQuery("SELECT * FROM docente d WHERE d.idusuario = ?", [idusuario]);
    if (res.length > 0) {
      return new Docente.fromMap(res.first);
    }
    return null;
  }

  Future<List<Clase>> getClasesByProfesor(int iddocente) async {
    dbCibertec = await con.database;
    print("entro al getclasesby porfesor q semustra en la interfaz");
    List res = await dbCibertec
        .rawQuery("SELECT * FROM clase c WHERE iddocente = ?", [iddocente]);
    List<Clase> list =
        res.isNotEmpty ? res.map((c) => Clase.fromMap(c)).toList() : null;
    print("se sta obteniendo data frmom docente" + list.length.toString());
    return list;
  }
Future<List<Clase>> getClasesByAlumno(int idalumno) async {
    dbCibertec = await con.database;

    List res = await dbCibertec
        .rawQuery("SELECT * FROM clase c,alumno_clase ac WHERE c.idclase = ac.idclase and ac.idalumno = ?", [idalumno]);
    List<Clase> list =
        res.isNotEmpty ? res.map((c) => Clase.fromMap(c)).toList() : null;
    print("se sta obteniendo data frmom docente" + list.length.toString());
    return list;
  }
  Future<Seccion> getSeccionByClase(int idclase) async {
    dbCibertec = await con.database;
    print("entro al getclasesby porfesor q semustra en la interfaz");
    var res = await dbCibertec.rawQuery(
        "SELECT * FROM seccion s, clase c WHERE s.idseccion = c.idseccion and c.idclase = ?",
        [idclase]);
    if (res.length > 0) {
      return new Seccion.fromMap(res.first);
    }
    return null;
  }

  Future<List<Alumno>> getAlumnosByClase(int idclase) async {
    dbCibertec = await con.database;
    List res = await dbCibertec.rawQuery(
        "SELECT * FROM alumno a,alumno_clase ac WHERE a.idalumno = ac.idalumno and ac.idclase = ?",
        [idclase]);
    List<Alumno> list =
        res.isNotEmpty ? res.map((c) => Alumno.fromMap(c)).toList() : null;
    return list;
  }

  Future<Nota> getNotaByClaseByAlumno(int idclase, int idalumno) async {
    dbCibertec = await con.database;
    var res = await dbCibertec.rawQuery(
        "SELECT * FROM nota n WHERE n.idclase = ?, n.idalumno = ?",
        [idclase, idalumno]);
    return new Nota.fromMap(res.first);
  }

  Future<Curso> getCursoByClase(int idclase) async {
    dbCibertec = await con.database;
    var res = await dbCibertec
        .rawQuery("SELECT * FROM curso c WHERE c.idcurso = ?", [idclase]);
    return new Curso.fromMap(res.first);
  }

  Future<List<Usuario>> getAllUsuario() async {
    dbCibertec = await con.database;
    var res = await dbCibertec.query("usuario");
    List<Usuario> list =
        res.isNotEmpty ? res.map((c) => Usuario.fromMap(c)).toList() : null;
    return list;
  }

  Future<List<Usuario>> getAllAlumno() async {
    dbCibertec = await con.database;
    var res = await dbCibertec.query("alumno");
    print(res);
    List<Usuario> list =
        res.isNotEmpty ? res.map((c) => Usuario.fromMap(c)).toList() : null;
    return list;
  }

  getAllClase() async {
    dbCibertec = await con.database;
    var res = await dbCibertec.query("clase");
    print(res);
  }

  getAllCurso() async {
    dbCibertec = await con.database;
    var res = await dbCibertec.query("curso");
    print(res);
  }

  deleteDB() async {
    dbCibertec = await con.database;
    await dbCibertec.delete("usuario");
    await dbCibertec.delete("alumno");
    await dbCibertec.delete("docente");
    await dbCibertec.delete("administrador");
    await dbCibertec.delete("turno");
    await dbCibertec.delete("carrera");
    await dbCibertec.delete("curso");
    await dbCibertec.delete("seccion");
    await dbCibertec.delete("clase");
    await dbCibertec.delete("alumno_clase");
    await dbCibertec.delete("nota");
    await dbCibertec.delete("matricula");
  }
}
