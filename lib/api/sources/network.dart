import 'package:dio/dio.dart';
import 'authenticator.dart';
import 'auto_retry_interceptor.dart';

class Network {
  static final public = Dio();
  static final auth = Dio();

  static void config({required baseUrl}) {
    public.options.baseUrl = baseUrl;
    auth.options.baseUrl = baseUrl;
  }

  static void setAuthCredential<Credential>(
    Credential credential,
    Authenticator<Credential> authenticator,
  ) {
    _removeAuthInterceptors();
    _addNewAuthInterceptors(credential, authenticator);
  }

  static void clearAuthCredential() {
    _removeAuthInterceptors();
  }

  static void _removeAuthInterceptors() {
    final autoRetryInterceptors =
        auth.interceptors.whereType<AutoRetryInterceptor>();
    for (var interceptor in autoRetryInterceptors) {
      interceptor.dispose();
    }
    auth.interceptors.clear();
  }

  static void _addNewAuthInterceptors<Credential>(
    Credential credential,
    Authenticator<Credential> authenticator,
  ) {
    auth.interceptors.add(
      AutoRetryInterceptor(
        client: auth,
        credential: credential,
        authenticator: authenticator,
      ),
    );
  }
}
