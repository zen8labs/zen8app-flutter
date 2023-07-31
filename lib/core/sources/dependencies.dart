import 'package:zen8app/utils/utils.dart';
import 'package:zen8app/api/api.dart';

void registerDependencies() {
  DI.register<LocalStore>(() => LocalStore());
  DI.register<AuthService>(() => AuthService());
  DI.register<MainService>(() => MainService());
}
