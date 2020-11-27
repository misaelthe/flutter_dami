class Nota {
  int _idnota;
  int _idclase;
  int _idalumno;
  int _e1;
  int _e2;
  int _ep;
  int _e3;
  int _ef;
  int _promedio;

  Nota(this._idnota, this._idclase, this._idalumno, this._e1, this._e2,
      this._ep, this._e3, this._ef, this._promedio);
  Nota.fromMap(dynamic obj) {
    this._idnota = obj['idnota'];
    this._idclase = obj['idclase'];
    this._idalumno = obj['idalumno'];
    this._e1 = obj['e1'];
    this._e2 = obj['e2'];
    this._ep = obj['ep'];
    this._e3 = obj['e3'];
    this._ef = obj['ef'];
    this._promedio = obj['promedio'];
  }
  Map<String, dynamic> toMap() {
    return {
      'idnota': _idnota,
      'idclase': _idclase,
      'idalumno': _idalumno,
      'e1': _e1,
      'e2': _e2,
      'ep': _ep,
      'e3': _e3,
      'ef': _ef,
      'promedio': _promedio,
    };
  }

  Nota.fromJson(Map<String, dynamic> json)
      : _idnota = json['idnota'],
        _idclase = json['clase']['idclase'],
        _idalumno = json['alumno']['idalumno'],
        _e1 = json['e1'],
        _e2 = json['e2'],
        _ep = json['ep'],
        _e3 = json['e3'],
        _ef = json['ef'],
        _promedio = json['promedio'];

  Map<String, dynamic> toJson() {
    return {
      "idnota": _idnota,
      "idclase": _idclase,
      "idalumno": _idalumno,
      "e1": _e1,
      "e2": _e2,
      "ep": _ep,
      "e3": _e3,
      "ef": _ef,
      "promedio": _promedio
    };
  }

  int get idnota => _idnota;
  int get idclase => idclase;
  int get idalumno => _idalumno;
  int get e1 => _e1;
  int get e2 => _e2;
  int get ep => _ep;
  int get e3 => _e3;
  int get ef => _ef;
  int get promedio => _promedio;

  set e1(int e1) => _e1 = e1;
  set e2(int e2) => _e2 = e2;
  set ep(int ep) => _ep = ep;
  set e3(int e3) => _e3 = e3;
  set ef(int ef) => _ef = ef;
  set promedio(int promedio) => _promedio = promedio;
}
