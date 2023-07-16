import 'credential.dart';
import 'user.dart';

class LoginResponse {
  Credential credential;
  User user;

  LoginResponse({
    required this.credential,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      credential: Credential.fromJson(json),
      user: User.fromJson(json["user"]),
    );
  }
}
