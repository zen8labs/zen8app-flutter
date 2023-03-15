import 'dart:async';

import 'package:flutter/material.dart';

typedef RxNotifierCallback<T> = void Function(T data);

class RxNotifier<T> extends StatefulWidget {
  final Stream<T>? stream;
  final RxNotifierCallback<T>? callback;
  final Widget child;

  const RxNotifier({
    Key? key,
    this.stream,
    this.callback,
    required this.child,
  }) : super(key: key);

  @override
  State<RxNotifier> createState() => RxNotifierState<T>();
}

class RxNotifierState<T> extends State<RxNotifier<T>> {
  StreamSubscription? _subscription;

  void _subscribe() {
    if (_subscription == null) {
      _subscription = widget.stream?.listen((data) {
        if (widget.callback != null) {
          widget.callback!(data);
        }
      });
    }
  }

  void _unsubscribe() {
    if (_subscription != null) {
      _subscription?.cancel();
      _subscription = null;
    }
  }

  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  @override
  void didUpdateWidget(covariant RxNotifier<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.stream != widget.stream) {
      _unsubscribe();
      _subscribe();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _unsubscribe();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
