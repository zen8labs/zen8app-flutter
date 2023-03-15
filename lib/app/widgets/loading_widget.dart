import 'package:flutter/material.dart';
import 'package:zen8app/lib.dart';

class LoadingWidget extends StatelessWidget {
  final Stream<bool>? isLoading;
  final Stream<AppError>? error;
  final Widget child;
  const LoadingWidget({
    Key? key,
    this.isLoading,
    this.error,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RxNotifier<AppError>(
      stream: error,
      callback: (error) => _showError(error, context),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          child,
          RxBuilder.from<bool>(
            stream: isLoading ?? const Stream.empty(),
            builder: (context, _, isLoading) {
              if (isLoading == true) {
                return _loadingIndicator();
              } else {
                return const SizedBox.shrink();
              }
            },
          )
        ],
      ),
    );
  }

  void _showError(AppError error, BuildContext context) {
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
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
