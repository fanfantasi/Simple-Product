import 'package:flutter/material.dart';

import 'loadingwidget.dart';

class RefreshLoadmore extends StatefulWidget {
  final Future<void> Function()? onRefresh;

  final Future<void> Function()? onLoadmore;

  final bool isLastPage;

  final Widget child;

  final Color? color;

  final Widget? noMoreWidget;

  final ScrollController? scrollController;

  const RefreshLoadmore({
    Key? key,
    required this.child,
    required this.isLastPage,
    this.onRefresh,
    this.color,
    this.onLoadmore,
    this.noMoreWidget,
    this.scrollController,
  }) : super(key: key);
  @override
  State<RefreshLoadmore> createState() => _RefreshLoadmoreState();
}

class _RefreshLoadmoreState extends State<RefreshLoadmore> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  ScrollController? _scrollController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController!.addListener(() async {
      if (_scrollController!.position.pixels >=
          _scrollController!.position.maxScrollExtent) {
        if (_isLoading) {
          return;
        }

        if (mounted) {
          setState(() {
            _isLoading = true;
          });
        }

        if (!widget.isLastPage && widget.onLoadmore != null) {
          await widget.onLoadmore!();
        }

        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    if (widget.scrollController == null) _scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget mainWiget = ListView(
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      children: [
        widget.child,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: _isLoading
                  ? LoadingWidget(leftcolor: Theme.of(context).primaryColor,)
                  : widget.isLastPage
                      ? widget.noMoreWidget ??
                          Text(
                            'No more data',
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).disabledColor,
                            ),
                          )
                      : Container(),
            ),
          ],
        )
      ],
    );

    if (widget.onRefresh == null) {
      return Scrollbar(child: mainWiget);
    }

    return RefreshIndicator(
      color: widget.color ?? Colors.blue,
      key: _refreshIndicatorKey,
      onRefresh: () async {
        if (_isLoading) return;
        await widget.onRefresh!();
      },
      child: mainWiget,
    );
  }
}
