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
  @override
  HomeVM onCreateVM() => HomeVM();

  @override
  void onBindingVM(CompositeSubscription subscription) {
    vm.input.reload.add(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onLongPress: () {
            EventBus.shared
                .post(event: AppEvent.forceLogout, data: "User log out");
          },
          child: Text(
            "Sự kiện của bạn",
            style:
                AppTheme.textStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: LoadingWidget(
        error: vm.errorTracker.asAppException(),
        isLoading: vm.activityTracker.isRunningAny(),
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}
