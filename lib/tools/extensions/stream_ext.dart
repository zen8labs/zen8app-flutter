import 'dart:async';

import 'package:rxdart/rxdart.dart';
import '../helpers/activity_tracker.dart';

extension StreamErrorTracking<T> on Stream<T> {
  Stream<T> handleErrorBy(Subject tracker) {
    return handleError((Object error, _) {
      tracker.add(error);
    });
  }
}

extension StreamActivityTracking<T> on Stream<T> {
  Stream<T> trackActivity(String activity, ActivityTracker tracker) {
    return doOnListen(() => tracker.start(activity))
        .doOnResume(() => tracker.start(activity))
        .doOnPause(() => tracker.stop(activity))
        .doOnCancel(() => tracker.stop(activity))
        .doOnDone(() => tracker.stop(activity))
        .doOnError((_, __) => tracker.stop(activity));
  }
}

extension StreamBinding<T> on Stream<T> {
  StreamSubscription<T> bindTo(Subject<T> subject) {
    return listen(subject.add);
  }
}
