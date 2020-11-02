import 'package:flutter_dami/services/login_request.dart';
import 'package:flutter_dami/model/Usuario.dart';

abstract class LoginCallBack {
  void onLoginSuccess(Usuario usuario);
  void onLoginError(String error);
}

class LoginResponse {
  LoginCallBack _callBack;
  LoginRequest loginRequest = new LoginRequest();
  LoginResponse(this._callBack);
  doLogin(String username, String password) {
    loginRequest
        .getLogin(username, password)
        .then((usuario) => _callBack.onLoginSuccess(usuario))
        .catchError((onError) => _callBack.onLoginError(onError.toString()));
  }
}
