import 'package:rxdart/rxdart.dart';
import 'package:zen8app/api/api.dart';
import 'package:zen8app/utils/utils.dart';
import 'package:zen8app/models/models.dart';

class HomeVMInput extends Disposable {}

class HomeVMOutput extends Disposable {
  final posts = BehaviorSubject<List<Post>>();
  @override
  void dispose() {
    posts.close();
  }
}

class HomeVM extends BaseVM<HomeVMInput, HomeVMOutput> {
  HomeVM() : super(HomeVMInput(), HomeVMOutput());

  final _mainService = DI.resolve<MainService>();
  late final _loader = PageLoader<String?, Page<Post>>((category, pages) {
    var nextPage = (pages.lastOrNull?.index ?? 0) + 1;
    return _mainService.getPosts(
      page: nextPage,
      pageSize: 20,
      category: category,
    );
  });

  @override
  ActivityTracker get activityTracker => _loader.activityTracker;

  @override
  PublishSubject get errorTracker => _loader.errorTracker;

  @override
  CompositeSubscription? connect() {
    var subscription = CompositeSubscription();

    _loader.pages
        .map((pages) => pages.expand((p) => p.items).toList())
        .bindTo(output.posts)
        .addTo(subscription);

    return subscription;
  }

  Future<bool> refresh({String? category}) {
    return _loader.refreshPage(category);
  }

  Future<bool> loadMore() => _loader.loadMorePage();
}
