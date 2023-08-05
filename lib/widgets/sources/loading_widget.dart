import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:zen8app/utils/utils.dart';
import 'package:zen8app/core/core.dart';
import 'package:zen8app/widgets/sources/custom_dialog.dart';

class RefreshController {
  final _refreshController = EasyRefreshController();

  final Axis? triggerAxis;
  final bool refreshOnStart;
  final Clip clipBehavior;
  final Future<bool> Function()? onRefresh;
  final Future<bool> Function()? onLoad;

  RefreshController({
    this.triggerAxis = Axis.vertical,
    this.refreshOnStart = false,
    this.clipBehavior = Clip.hardEdge,
    this.onRefresh,
    this.onLoad,
  });

  Future callRefresh({
    double? overOffset,
    Duration? duration = const Duration(milliseconds: 200),
    Curve curve = Curves.linear,
    ScrollController? scrollController,
  }) async {
    await _refreshController.callRefresh(
      overOffset: overOffset,
      duration: duration,
      curve: curve,
      scrollController: scrollController,
    );
  }

  Future callLoad({
    double? overOffset,
    Duration? duration = const Duration(milliseconds: 300),
    Curve curve = Curves.linear,
    ScrollController? scrollController,
  }) async {
    await _refreshController.callLoad(
      overOffset: overOffset,
      duration: duration,
      curve: curve,
      scrollController: scrollController,
    );
  }

  void resetHeader() {
    _refreshController.resetHeader();
  }

  void resetFooter() {
    _refreshController.resetFooter();
  }

  Future _onTriggerRefresh() async {
    if (onRefresh != null) {
      try {
        bool hasMore = await onRefresh!();
        return hasMore ? IndicatorResult.success : IndicatorResult.noMore;
      } catch (e) {
        return IndicatorResult.fail;
      }
    }
  }

  Future _onTriggerLoad() async {
    if (onLoad != null) {
      try {
        var hasMore = await onLoad!();
        return hasMore ? IndicatorResult.success : IndicatorResult.noMore;
      } catch (e) {
        return IndicatorResult.fail;
      }
    }
  }
}

class LoadingWidget extends StatefulWidget {
  final Stream<bool>? isLoading;
  final Stream<AppException>? error;
  final RefreshController? refreshController;

  final Widget Function(BuildContext context, ScrollPhysics? physics) builder;
  final Widget? Function(BuildContext context)? emptyStateBuilder;

  const LoadingWidget.builder({
    Key? key,
    this.isLoading,
    this.error,
    this.refreshController,
    this.emptyStateBuilder,
    required this.builder,
  }) : super(key: key);

  LoadingWidget({
    Key? key,
    Stream<bool>? isLoading,
    Stream<AppException>? error,
    Widget? Function(BuildContext context)? emptyStateBuilder,
    RefreshController? refreshController,
    required Widget child,
  }) : this.builder(
          key: key,
          isLoading: isLoading,
          error: error,
          refreshController: refreshController,
          emptyStateBuilder: emptyStateBuilder,
          builder: (context, physics) => child,
        );

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
      alignment: Alignment.center,
      children: [
        switch (widget.refreshController) {
          var controller? => EasyRefresh.builder(
              header: const MaterialHeader(color: Color(0xFF0269E9)),
              footer: const MaterialFooter(
                color: Color(0xFF0269E9),
                noMoreIcon: Icon(
                  Icons.check,
                  color: Color(0xFFA3A3A3),
                ),
              ),
              childBuilder: widget.builder,
              controller: controller._refreshController,
              canRefreshAfterNoMore: true,
              triggerAxis: controller.triggerAxis,
              refreshOnStart: controller.refreshOnStart,
              clipBehavior: controller.clipBehavior,
              onRefresh: controller.onRefresh != null
                  ? controller._onTriggerRefresh
                  : null,
              onLoad:
                  controller.onLoad != null ? controller._onTriggerLoad : null,
            ),
          _ => widget.builder(context, null),
        },
        StreamBuilder(
          stream: widget.isLoading,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case true:
                return (widget.refreshController?.onRefresh == null)
                    ? _loadingIndicator()
                    : const SizedBox.shrink();
              case false:
                if (widget.emptyStateBuilder != null) {
                  return widget.emptyStateBuilder!(context) ??
                      const SizedBox.shrink();
                } else {
                  return const SizedBox.shrink();
                }
              default:
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
        return CustomDialog(
          title: "Có lỗi xảy ra",
          description: error.toString(),
          rightAction: DialogAction(
            title: "Đóng",
            onTap: () => Navigator.pop(context),
          ),
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return Container(
      color: Colors.white.withOpacity(0.1),
      alignment: Alignment.center,
      child: const CircularProgressIndicator(color: AppTheme.primaryColor),
    );
  }
}
