class Docente {
  int _iddocente;
  String _nombre;
  String _dni;
  int _idusuario;
  int _idcarrera;
  String _telefono;
  String _correo;
  String _direccion;
  String _fecnac;

  Docente(
      this._iddocente,
      this._nombre,
      this._dni,
      this._idusuario,
      this._idcarrera,
      this._telefono,
      this._correo,
      this._direccion,
      this._fecnac);
  Docente.fromMap(dynamic obj) {
    this._iddocente = obj['iddocente'];
    this._nombre = obj['nombre'];
    this._dni = obj['dni'];
    this._idusuario = obj['idusuario'];
    this._idcarrera = obj['idcarrera'];
    this._telefono = obj['telefono'];
    this._correo = obj['correo'];
    this._direccion = obj['direccion'];
    this._fecnac = obj['fecnac'];
  }
  Map<String, dynamic> toMap() {
    return {
      'iddocente': _iddocente,
      'nombre': _nombre,
      'dni': _dni,
      'idusuario': _idusuario,
      'idcarrera': _idcarrera,
      'telefono': _telefono,
      'correo': _correo,
      'direccion': _direccion,
      'fecnac': _fecnac,
    };
  }

  Docente.fromJson(Map<String, dynamic> json)
      : _iddocente = json['iddocente'],
        _nombre = json['nombre'],
        _dni = json['dni'],
        _idusuario = json['usuario']['idusuario'],
        _idcarrera = json['carrera']['idcarrera'],
        _telefono = json['telefono'],
        _correo = json['correo'],
        _direccion = json['direccion'],
        _fecnac = json['fecnac'];

  int get iddocente => _iddocente;
  String get nombre => _nombre;
  String get dni => _dni;
  int get idusuario => _idusuario;
  int get idcarrera => _idcarrera;
  String get telefono => _telefono;
  String get correo => _correo;
  String get direccion => _direccion;
  String get fecnac => _fecnac;
}
