import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:zen8app/utils/utils.dart';
import 'package:zen8app/models/models.dart';
import 'package:zen8app/core/core.dart';

class DefaultAuthenticator extends Authenticator<Credential> {
  @override
  void applyCredential(Credential credential, RequestOptions options) {
    options.headers["Authorization"] = "Bearer ${credential.token}";
  }

  @override
  bool shouldRefreshCredential(DioException error) {
    return error.response?.statusCode == 401 &&
        error.requestOptions.retryCount == 0;
  }

  @override
  bool isRequestAuthenticatedWithCredential(
      RequestOptions options, Credential credential) {
    final requestAuthorizationHeader = options.headers["Authorization"];
    final currentAuthorizationHeader = "Bearer ${credential.token}";
    return requestAuthorizationHeader == currentAuthorizationHeader;
  }

  @override
  Future<Credential> refreshCredential(Credential oldCredential, Dio client) {
    return client.post("/auth/refresh/").then((response) {
      final credential = Credential.fromJson(response.data);
      DI
          .resolve<LocalStore>()
          .setValue(LocalStoreKey.credential, jsonEncode(credential));
      return credential;
    }).catchError((e) {
      EventBus.shared
          .post(event: AppEvent.forceLogout, data: "can not refresh token");
    });
  }
}
