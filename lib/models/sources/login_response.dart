import 'auth_credential.dart';
import 'user.dart';

class LoginResponse {
  AuthCredential credential;
  User user;

  LoginResponse(this.credential, this.user);

  static LoginResponse fromJson(Map<String, dynamic> json) =>
      LoginResponse(AuthCredential(json["token"], ""), User.fromJson(json));
}
