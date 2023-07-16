import 'package:rxdart/rxdart.dart';
import 'package:zen8app/utils/utils.dart';

class EventBus extends Disposable {
  static final shared = EventBus();

  final _bus = PublishSubject<(String, dynamic)>();

  @override
  void dispose() {
    _bus.close();
  }

  void post({required String event, dynamic data}) {
    if (!_bus.isClosed) {
      _bus.add((event, data));
    }
  }

  Stream<T> get<T>(String event) {
    return _bus.where((e) => (e.$1 == event && e.$2 is T)).map((e) => e.$2);
  }
}
