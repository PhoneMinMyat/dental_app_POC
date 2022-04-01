import 'package:flutter/material.dart';

class SmartListView extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder builder;
  final Function onListReachedEnd;
  final Function onListReachedStart;
  const SmartListView(this.onListReachedStart, this.onListReachedEnd,
      {required this.itemCount, required this.builder, Key? key})
      : super(key: key);

  @override
  State<SmartListView> createState() => _SmartListViewState();
}

class _SmartListViewState extends State<SmartListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          widget.onListReachedStart;
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Refreshed')));
        } else {
          widget.onListReachedEnd;
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Load More')));
        }
      }
    });
    super.initState();
  }

  Future<void> onRefresh() {
    return Future.delayed(const Duration(seconds: 1)).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Refreshed')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: (widget.itemCount == 0)
          ? const Center(
              child: Text('There is no data'),
            )
          : RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 0),
                controller: _scrollController,
                itemCount: widget.itemCount,
                itemBuilder: widget.builder,
              ),
            ),
    );
  }
}
