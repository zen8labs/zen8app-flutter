import 'package:rxdart/rxdart.dart';
import 'disposable.dart';

class ActivityTracker implements Disposable {
  final _cache = BehaviorSubject<Map<String, bool>?>.seeded(null);

  void start(String activity) {
    var allActivities = _cache.value ?? {};
    if (!_cache.isClosed && allActivities[activity] != true) {
      allActivities[activity] = true;
      _cache.add(allActivities);
    }
  }

  void stop(String activity) {
    var allActivities = _cache.value ?? {};
    if (!_cache.isClosed && allActivities[activity] != false) {
      allActivities[activity] = false;
      _cache.add(allActivities);
    }
  }

  Stream<bool> isRunning(String activity) {
    return _cache
        .mapNotNull((activitiesMap) => activitiesMap?[activity])
        .distinct();
  }

  Stream<bool> isRunningAnyOf(Set<String> activities) {
    return _cache
        .whereType<Map<String, bool>>()
        .map((activitiesMap) =>
            activities.any((activity) => activitiesMap[activity] ?? false))
        .distinct();
  }

  Stream<bool> isRunningAny() {
    return _cache
        .whereType<Map<String, bool>>()
        .map((activitiesMap) => activitiesMap.values.contains(true))
        .distinct();
  }

  @override
  void dispose() {
    _cache.close();
  }
}
