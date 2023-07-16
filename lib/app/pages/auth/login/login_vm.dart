import 'package:rxdart/rxdart.dart';
import 'package:zen8app/api/api.dart';
import 'package:zen8app/utils/utils.dart';
import 'package:zen8app/models/models.dart';

class LoginVMInput extends Disposable {
  final login = PublishSubject<(String, String)>();
  @override
  void dispose() {
    login.close();
  }
}

class LoginVMOutput extends Disposable {
  final response = PublishSubject<LoginResponse>();

  @override
  void dispose() {
    response.close();
  }
}

class LoginVM extends BaseVM<LoginVMInput, LoginVMOutput> {
  LoginVM() : super(LoginVMInput(), LoginVMOutput());

  @override
  CompositeSubscription? connect() {
    final rxBag = CompositeSubscription();
    final authService = DI.resolve<AuthService>();

    input.login
        .switchMap((param) => authService
            .login(param.$1, param.$2)
            .trackActivity("loading", activityTracker))
        .handleErrorBy(errorTracker)
        .bindTo(output.response)
        .addTo(rxBag);

    return rxBag;
  }
}
