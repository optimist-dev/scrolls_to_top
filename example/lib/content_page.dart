import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scrolls_to_top/scrolls_to_top.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({
    Key? key,
    required this.backgroundColor,
    required this.stream,
  }) : super(key: key);

  final Color backgroundColor;
  final Stream<ScrollToStartEvent> stream;

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  final _scrollController = ScrollController();
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = widget.stream.listen(_onScrollsToTop);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScrollController(
      controller: _scrollController,
      child: Scaffold(
        primary: true,
        body: _list(),
        backgroundColor: widget.backgroundColor,
      ),
    );
  }

  Widget _list() {
    return ListView.builder(
      itemBuilder: _itemBuilder,
      itemCount: 100,
      controller: _scrollController,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Text('$index', style: const TextStyle(fontSize: 20)),
    );
  }

  Future<void> _onScrollsToTop(ScrollToStartEvent event) async {
    debugPrint('Scroll to top!');
    _scrollController.animateTo(
      event.to,
      duration: event.duration,
      curve: event.curve,
    );
  }
}
