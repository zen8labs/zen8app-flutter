import 'dart:async';
import 'package:zen8app/tools/helpers/disposable.dart';

class BaseVM<Input extends Disposable, Output extends Disposable>
    implements Disposable {
  Input input;
  Output output;

  StreamSubscription? _subscription;

  BaseVM(this.input, this.output) {
    _subscription = connect(input, output);
  }

  StreamSubscription? connect(Input input, Output output) {
    return null;
  }

  @override
  void dispose() {
    input.dispose();
    output.dispose();
    _subscription?.cancel();
  }
}




/*
class TestInput {}

class TestOutput {}

class TestVM extends BaseVM<TestInput, TestOutput> {
  @override
  final input = TestInput();

  @override
  TestOutput transform(TestInput input) {
    // TODO: implement transform
    throw UnimplementedError();
  }

  @override
  void dispose() {}
}

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final vm = TestVM();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
*/