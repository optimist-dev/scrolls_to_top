import 'package:example/content_page.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scrolls_to_top/scrolls_to_top.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<PublishSubject<ScrollsToTopEvent>> _streams = [
    PublishSubject<ScrollsToTopEvent>(),
    PublishSubject<ScrollsToTopEvent>(),
    PublishSubject<ScrollsToTopEvent>(),
  ];
  final List<Widget> _children = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _children.addAll(
      [
        ContentPage(backgroundColor: Colors.white, stream: _streams[0]),
        ContentPage(backgroundColor: Colors.deepOrange, stream: _streams[1]),
        ContentPage(backgroundColor: Colors.green, stream: _streams[2]),
      ],
    );
  }

  @override
  void dispose() {
    for (var it in _streams) {
      it.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollsToTop(
      child: Scaffold(
        appBar: AppBar(title: const Text('Scroll to top')),
        body: IndexedStack(
          index: _currentIndex,
          children: _children,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Messages'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
          ],
        ),
      ),
      onScrollsToTop: _onScrollsToTop,
    );
  }

  Future<void> _onScrollsToTop(ScrollsToTopEvent event) async {
    _streams[_currentIndex].add(event);
  }

  Widget _body() {
    return Container();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
