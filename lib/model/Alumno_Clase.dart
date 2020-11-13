class Alumno_Clase {
  int _idalumno_clase;
  int _idalumno;
  int _idclase;

  Alumno_Clase(this._idalumno_clase, this._idalumno, this._idclase);
  Alumno_Clase.fromMap(dynamic obj) {
    this._idalumno_clase = obj['idalumno_clase'];
    this._idalumno = obj['idalumno'];
    this._idclase = obj['idclase'];
  }
  Map<String, dynamic> toMap() {
    return {
      'idalumno_clase': _idalumno_clase,
      'idalumno': _idalumno,
      'idclase': _idclase
    };
  }

  Alumno_Clase.fromJson(Map<String, dynamic> json)
      : _idalumno_clase = json['idalumno_clase'],
        _idalumno = json['idalumno'],
        _idclase = json['idclase'];

  int get idalumno_clase => _idalumno_clase;
  int get idalumno => _idalumno;
  int get idclase => _idclase;
}
