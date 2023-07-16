import 'package:rxdart/rxdart.dart';
import 'package:zen8app/api/api.dart';
import 'package:zen8app/utils/utils.dart';
import 'package:zen8app/models/models.dart';

class HomeVMInput extends Disposable {
  final reload = PublishSubject();
  @override
  void dispose() {
    reload.close();
  }
}

class HomeVMOutput extends Disposable {
  @override
  void dispose() {}
}

class HomeVM extends BaseVM<HomeVMInput, HomeVMOutput> {
  HomeVM() : super(HomeVMInput(), HomeVMOutput());

  @override
  CompositeSubscription? connect() {
    final rxBag = CompositeSubscription();
    final mainService = DI.resolve<MainService>();

    return rxBag;
  }
}
