import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scrolls_to_top/scrolls_to_top.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({
    Key? key,
    required this.backgroundColor,
    required this.isOnScreen,
  }) : super(key: key);

  final Color backgroundColor;
  final bool isOnScreen;

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      body: _list(),
      backgroundColor: widget.backgroundColor,
    );
  }

  Widget _list() {
    return ScrollsToTop(
      onScrollsToTop: _onScrollsToTop,
      child: ListView.builder(
        itemBuilder: _itemBuilder,
        itemCount: 100,
        controller: _scrollController,
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
      ),
      padding: const EdgeInsets.all(20),
      child: Text('$index', style: const TextStyle(fontSize: 20)),
    );
  }

  Future<void> _onScrollsToTop(ScrollsToTopEvent event) async {
    if (!widget.isOnScreen) return;

    debugPrint('Scroll to top!');
    _scrollController.animateTo(
      event.to,
      duration: event.duration,
      curve: event.curve,
    );
  }
}
