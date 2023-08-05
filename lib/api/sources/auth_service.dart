import 'package:rxdart/rxdart.dart';
import 'package:zen8app/core/core.dart';
import 'package:zen8app/utils/utils.dart';
import 'package:zen8app/models/models.dart';

class AuthService {
  Stream<LoginResponse> login(String username, String password) {
    return Stream.value(LoginResponse(
            credential: Credential(token: "123"),
            user: User(id: 1, name: "User 1", email: "", isAdmin: true)))
        .delay(Duration(seconds: 1));

    return Session.publicClient.postStream("/auth/login", data: {
      "email": username,
      "password": password
    }).decode((json) => LoginResponse.fromJson(json));
  }
}
