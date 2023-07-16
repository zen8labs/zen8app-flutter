import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zen8app/utils/utils.dart';
import 'package:zen8app/core/core.dart';

class LoadingWidget extends StatefulWidget {
  final Stream<bool>? isLoading;
  final Stream<AppException>? error;
  final Widget child;
  const LoadingWidget({
    Key? key,
    this.isLoading,
    this.error,
    required this.child,
  }) : super(key: key);

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  final _rxBag = CompositeSubscription();

  @override
  void initState() {
    super.initState();
    widget.error?.listen((error) {
      _showError(error, context);
    }).addTo(_rxBag);
  }

  @override
  void dispose() {
    super.dispose();
    _rxBag.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        widget.child,
        StreamBuilder(
          stream: widget.isLoading,
          builder: (context, snapshot) {
            if (snapshot.data ?? false) {
              return _loadingIndicator();
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }

  void _showError(AppException error, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        Widget closeButton = TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Đóng"),
        );
        return AlertDialog(
          title: const Text("Có lỗi xảy ra"),
          content: Text(error.toString()),
          actions: [
            closeButton,
          ],
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return Container(
      color: Colors.white.withOpacity(0.1),
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: AppTheme.primaryColor,
      ),
    );
  }
}
