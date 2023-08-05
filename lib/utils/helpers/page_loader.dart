import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:zen8app/utils/utils.dart';

class PageLoader<Param, Page extends PageType> extends Disposable {
  final _sub = CompositeSubscription();
  final _reload = PublishSubject<(Completer<bool>, Param)>();
  final _next = PublishSubject<Completer<bool>>();
  final activityTracker = ActivityTracker();
  final errorTracker = PublishSubject();

  final _cache = BehaviorSubject<(Param, List<Page>)>();

  Stream<List<Page>> get pages {
    return _cache.map((e) => e.$2);
  }

  Stream<dynamic> get errors {
    return errorTracker.stream;
  }

  Stream<bool> get isReloading {
    return activityTracker.isRunning('reloading');
  }

  Stream<bool> get isLoadingMore {
    return activityTracker.isRunning('loadingMore');
  }

  Stream<bool> get hasMorePage {
    return _cache.map((e) => e.$2.lastOrNull?.hasMore ?? false).distinct();
  }

  Stream<bool> get isFirstLoading {
    return _cache.take(1).mapTo(false).startWith(true);
  }

  PageLoader(Stream<Page> Function(Param param, List<Page> pages) loadingFunc) {
    var reloadTask = _reload.map((element) {
      var (completer, param) = element;
      return (
        true,
        completer,
        loadingFunc(param, [])
            .map((newPage) => (param, [newPage]))
            .trackActivity('reloading', activityTracker)
      );
    });

    Stream<(bool, Completer<bool>, Stream<(Param, List<Page>)>)> nextTask =
        _next.withLatestFrom(_cache, (completer, current) {
      var (param, pages) = current;
      return (pages.lastOrNull?.hasMore ?? false)
          ? (
              true,
              completer,
              loadingFunc(param, pages)
                  .map((newPage) => (param, pages + [newPage]))
                  .trackActivity("loadingMore", activityTracker),
            )
          : (false, completer, const Stream.empty());
    });

    Rx.switchLatest(
      Rx.merge([reloadTask, nextTask]).map(
        (element) {
          var (prevHasMore, completer, task) = element;
          return task
              .doOnData((e) {
                completer.complete(e.$2.lastOrNull?.hasMore ?? false);
              })
              .doOnError(completer.completeError)
              .doOnCancel(() {
                if (!completer.isCompleted) completer.complete(prevHasMore);
              });
        },
      ),
    ).handleErrorBy(errorTracker).bindTo(_cache).addTo(_sub);
  }

  Future<bool> refreshPage(Param param) {
    var completer = Completer<bool>();
    if (!_reload.isClosed) _reload.add((completer, param));
    return completer.future;
  }

  Future<bool> loadMorePage() {
    var completer = Completer<bool>();
    if (!_next.isClosed) _next.add(completer);
    return completer.future;
  }

  clearPages() {
    if (_cache.hasValue) {
      var (param, _) = _cache.value;
      _cache.add((param, []));
    }
  }

  @override
  void dispose() {
    _sub.dispose();
    _reload.close();
    _next.close();
    _cache.close();
    activityTracker.dispose();
    errorTracker.close();
  }
}

class SimplePageLoader<Page extends PageType>
    extends PageLoader<dynamic, Page> {
  SimplePageLoader(Stream<Page> Function(List<Page> pages) loadingFunc)
      : super((_, pages) => loadingFunc(pages));
}
