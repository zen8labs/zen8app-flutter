import 'package:dio/dio.dart';
import 'package:zen8app/lib.dart';

class CommonAuthenticator extends Authenticator<AuthCredential> {
  @override
  void applyCredential(AuthCredential credential, RequestOptions options) {
    options.headers["Authorization"] = "JWT ${credential.accessToken}";
  }

  @override
  bool isRequestAuthenticatedWithCredential(
      RequestOptions options, AuthCredential credential) {
    final requestAuthorizationHeader = options.headers["Authorization"];
    final currentAuthorizationHeader = "JWT ${credential.accessToken}";
    return requestAuthorizationHeader == currentAuthorizationHeader;
  }

  @override
  Future<AuthCredential> refreshCredential(
      AuthCredential oldCredential, Dio client) async {
    try {
      final res = await client.post("/api/v1/auth/refresh/");
      return AuthCredential.fromJson(res.data);
    } catch (_) {
      Session.endAuthenticatedSession(reason: 'Can not refresh token');
      rethrow;
    }
  }
}
