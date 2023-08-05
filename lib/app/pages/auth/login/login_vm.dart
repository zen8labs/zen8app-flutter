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
  //output triggers event should be a PublishSubject, but output that's showing on the UI should be a BehaviorSubject
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
    final subscription = CompositeSubscription();
    final authService = DI.resolve<AuthService>();

    input.login
        .switchMap((param) => authService
            .login(param.$1, param.$2)
            .trackActivity("loading", activityTracker))
        .handleErrorBy(errorTracker)
        .bindTo(output.response)
        .addTo(subscription);

    return subscription;
  }
}
