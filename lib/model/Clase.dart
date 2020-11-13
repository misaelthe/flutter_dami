class Clase {
  int _idclase;
  int _idseccion;
  int _idcurso;
  int _iddocente;
  int _alum_ins;

  Clase(this._idclase, this._idseccion, this._idcurso, this._iddocente,
      this._alum_ins);
  Clase.fromMap(dynamic obj) {
    this._idclase = obj['idclase'];
    this._idseccion = obj['idseccion'];
    this._idcurso = obj['idcurso'];
    this._iddocente = obj['iddocente'];
    this._alum_ins = obj['alum_ins'];
  }
  Map<String, dynamic> toMap() {
    return {
      'idclase': _idclase,
      'idseccion': _idseccion,
      'idcurso': _idcurso,
      'iddocente': _iddocente,
      'alum_ins': _alum_ins
    };
  }

  Clase.fromJson(Map<String, dynamic> json)
      : _idclase = json['idclase'],
        _idseccion = json['idseccion'],
        _idcurso = json['idcurso'],
        _iddocente = json['iddocente'],
        _alum_ins = json['alum_ins'];

  int get idclase => _idclase;
  int get idseccion => _idseccion;
  int get idcurso => _idcurso;
  int get iddocente => _iddocente;
  int get alum_ins => _alum_ins;
}
