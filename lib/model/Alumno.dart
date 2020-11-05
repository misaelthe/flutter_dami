class Alumno {
  int _idalumno;
  String _nombre;
  String _dni;
  int _idusuario;
  String _telefono;
  String _correo;
  String _direccion;
  String _fecnac;

  Alumno(this._idalumno, this._nombre, this._dni, this._idusuario,
      this._telefono, this._correo, this._direccion, this._fecnac);
  Alumno.fromMap(dynamic obj) {
    this._idalumno = obj['idalumno'];
    this._nombre = obj['nombre'];
    this._dni = obj['dni'];
    this._idusuario = obj['idusuario'];
    this._telefono = obj['telefono'];
    this._correo = obj['correo'];
    this._direccion = obj['direccion'];
    this._fecnac = obj['fecnac'];
  }
  Map<String, dynamic> toMap() {
    return {
      'idalumno': _idalumno,
      'nombre': _nombre,
      'dni': _dni,
      'idusuario': _idusuario,
      'telefono': _telefono,
      'correo': _correo,
      'direccion': _direccion,
      'fecnac': _fecnac,
    };
  }

  int get idalumno => _idalumno;
  String get nombre => _nombre;
  String get dni => _dni;
  int get idusuario => _idusuario;
  String get telefono => _telefono;
  String get correo => _correo;
  String get direccion => _direccion;
  String get fecnac => _fecnac;
}
