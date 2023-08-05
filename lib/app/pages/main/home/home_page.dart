import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zen8app/app/pages/main/home/home_vm.dart';
import 'package:zen8app/core/core.dart';
import 'package:zen8app/models/models.dart';
import 'package:zen8app/utils/utils.dart';
import 'package:zen8app/router/router.dart';
import 'package:zen8app/widgets/widgets.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with MVVMBinding<HomeVM, HomePage> {
  var _posts = <Post>[];
  @override
  HomeVM onCreateVM() => HomeVM();

  @override
  void onBindingVM(CompositeSubscription subscription) {
    vm.output.posts.listen((newPosts) {
      setState(() {
        _posts = newPosts;
      });
    }).addTo(subscription);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: AppTheme.textStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
              onPressed: () {
                EventBus.shared
                    .post(event: AppEvent.forceLogout, data: "User log out");
              },
              child: Text(
                'Logout',
                style: AppTheme.textStyle(color: Colors.red),
              ))
        ],
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: LoadingWidget.builder(
        refreshController: RefreshController(
          onLoad: vm.loadMore,
          onRefresh: vm.refresh,
          refreshOnStart: true,
        ),
        error: vm.errorTracker.asAppException(),
        isLoading: vm.activityTracker.isRunningAny(),
        emptyStateBuilder: (context) {
          return _posts.isEmpty ? const Text('Không có bài viết nào!') : null;
        },
        builder: (context, physics) => ListView.builder(
          physics: physics,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          itemBuilder: (context, index) {
            var aPost = _posts[index];
            return ListTile(
              title: Text(aPost.title),
              onTap: () {
                print('tap on post: ${aPost.id}');
              },
            );
          },
          itemCount: _posts.length,
        ),
      ),
    );
  }
}
