class Usuario {
  int _idusuario;
  String _usuario;
  String _password;
  int _credencial;

  Usuario(this._idusuario, this._usuario, this._password, this._credencial);
  Usuario.fromMap(dynamic obj) {
    this._idusuario = obj['idusuario'];
    this._usuario = obj['usuario'];
    this._password = obj['password'];
    this._credencial = obj['credencial'];
  }
  Map<String, dynamic> toMap() {
    return {
      'idusuario': _idusuario,
      'usuario': _usuario,
      'password': _password,
      'credencial': _credencial,
    };
  }

  int get idusuario => _idusuario;
  String get usuario => _usuario;
  String get password => _password;
  int get credencial => _credencial;
  /*@override
  String toString() {
    return 'Usuario{id: $id, name: $name, age: $age}';
  }*/
}
