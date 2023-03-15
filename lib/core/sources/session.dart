import 'dart:convert';
import 'package:zen8app/lib.dart';

class Session {
  static Env _currentEnv = Env.dev;
  static Env get currentEnv => _currentEnv;

  static Config _currentConfig = Config.dev;
  static Config get currentConfig => _currentConfig;

  static User? _currentUser;
  static User? get currentUser => _currentUser;

  static bool get isLoggedIn => _currentUser != null;

  static final _logoutEvents = PublishSubject<String?>();
  static Stream<String?> get logoutEvent => _logoutEvents.stream;

  Session._();

  static Future<void> initialize(Env env) async {
    //setup env, configurations
    _currentEnv = env;
    _currentConfig = Config.env(env);

    //config network
    Network.config(
      baseUrl: _currentConfig.baseUrl,
    );

    _currentUser = await LocalStore.getValue(
      LocalStoreKey.loggedInUser,
      transform: (value) => User.fromJson(jsonDecode(value)),
    );

    final credential = await LocalStore.getValue(
      LocalStoreKey.authCredential,
      transform: (value) => AuthCredential.fromJson(jsonDecode(value)),
    );

    if (credential != null) {
      Network.setAuthCredential(credential, CommonAuthenticator());
    }
  }

  static Future<void> startAuthenticatedSession(
      AuthCredential credential, User loggedUser) async {
    await LocalStore.setValue(
        LocalStoreKey.authCredential, jsonEncode(credential));
    await LocalStore.setValue(
        LocalStoreKey.loggedInUser, jsonEncode(loggedUser));
    _currentUser = loggedUser;
    Network.setAuthCredential(credential, CommonAuthenticator());
  }

  static Future<void> endAuthenticatedSession({String? reason}) async {
    await LocalStore.removeMany([
      LocalStoreKey.authCredential,
      LocalStoreKey.loggedInUser,
    ]);
    _currentUser = null;
    Network.clearAuthCredential();
  }
}
