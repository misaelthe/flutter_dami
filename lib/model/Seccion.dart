class Seccion {
  int _idseccion;
  String _codigo;
  int _idcarrera;
  int _ciclo;

  Seccion(this._idseccion, this._codigo, this._idcarrera, this._ciclo);
  Seccion.fromMap(dynamic obj) {
    this._idseccion = obj['idseccion'];
    this._codigo = obj['codigo'];
    this._idcarrera = obj['idcarrera'];
    this._ciclo = obj['ciclo'];
  }
  Map<String, dynamic> toMap() {
    return {
      'idseccion': _idseccion,
      'codigo': _codigo,
      'idcarrera': _idcarrera,
      'ciclo': _ciclo
    };
  }

  Seccion.fromJson(Map<String, dynamic> json)
      : _idseccion = json['idseccion'],
        _codigo = json['codigo'],
        _idcarrera = json['carrera']['idcarrera'],
        _ciclo = json['ciclo'];

  int get idseccion => _idseccion;
  String get codigo => _codigo;
  int get idcarrera => _idcarrera;
  int get ciclo => _ciclo;
}
