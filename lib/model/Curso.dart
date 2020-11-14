class Curso {
  int _idcurso;
  String _nombre;
  int _idcarrera;
  int _ciclo;

  Curso(this._idcurso, this._nombre, this._idcarrera, this._ciclo);

  Curso.fromMap(dynamic obj) {
    this._idcurso = obj['idcurso'];
    this._nombre = obj['nombre'];
    this._idcarrera = obj['idcarrera'];
    this._ciclo = obj['ciclo'];
  }
  Map<String, dynamic> toMap() {
    return {
      'idcurso': _idcurso,
      'nombre': _nombre,
      'idcarrera': _idcarrera,
      'ciclo': _ciclo
    };
  }

  Curso.fromJson(Map<String, dynamic> json)
      : _idcurso = json['idcurso'],
        _nombre = json['nombre'],
        _idcarrera = json['carrera']['idcarrera'],
        _ciclo = json['ciclo'];

  int get idcurso => _idcurso;
  String get nombre => _nombre;
  int get idcarrera => _idcarrera;
  int get ciclo => _ciclo;
}
