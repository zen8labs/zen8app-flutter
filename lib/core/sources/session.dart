import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:zen8app/utils/utils.dart';
import 'package:zen8app/models/models.dart';
import 'package:zen8app/core/core.dart';
import 'authenticator.dart';

class Session {
  static final publicClient = Dio();
  static final authClient = Dio();

  static User? _currentUser;
  static User? get currentUser => _currentUser;
  static bool get isLoggedIn => _currentUser != null;

  Session._();

  //Resume session
  static Future<void> initialize() async {
    //config network
    publicClient.options.baseUrl = Config.currentConfig.baseUrl;
    authClient.options.baseUrl = Config.currentConfig.baseUrl;

    var store = DI.resolve<LocalStore>();

    //load previous credentials
    _currentUser = await store.getValue(
      LocalStoreKey.user,
      transform: (value) => User.fromJson(jsonDecode(value)),
    );

    final credential = await store.getValue(
      LocalStoreKey.credential,
      transform: (value) => Credential.fromJson(jsonDecode(value)),
    );
    if (credential != null) {
      authClient.setAuthCredential(
        credential: credential,
        authenticator: DefaultAuthenticator(),
      );
    }
  }

  //Start a new session
  static Future<void> startAuthenticatedSession(LoginResponse response) async {
    var store = DI.resolve<LocalStore>();
    await store.setValue(
      LocalStoreKey.user,
      jsonEncode(response.user),
    );
    _currentUser = response.user;

    await store.setValue(
      LocalStoreKey.credential,
      jsonEncode(response.credential),
    );
    authClient.setAuthCredential(
      credential: response.credential,
      authenticator: DefaultAuthenticator(),
    );
  }

  //End a session
  static Future<void> endAuthenticatedSession({String? reason}) async {
    await DI.resolve<LocalStore>().removeMany([
      LocalStoreKey.credential,
      LocalStoreKey.user,
    ]);

    _currentUser = null;
    authClient.clearAuthCredential();
  }
}
