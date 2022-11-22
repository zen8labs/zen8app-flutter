import 'package:rxdart/rxdart.dart';
import 'package:async/async.dart';

class HomeViewModel {
  final PublishSubject<void> inLogin;
  final Stream<String> outToken;

  HomeViewModel._(this.inLogin, this.outToken);

  factory HomeViewModel() {
    var inLogin = PublishSubject<void>();

    var outToken = inLogin.switchMap((value) => HomeViewModel.login());

    return HomeViewModel._(inLogin, outToken);
  }

  static Stream<String> login() async* {
    yield await Future.delayed(Duration(seconds: 3), () => "123456");
  }
}
