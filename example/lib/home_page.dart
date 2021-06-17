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
  int _currentIndex = 0;

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
      onScrollsToTop: _onScrollsToTop,
      scaffold: Scaffold(
        appBar: AppBar(title: const Text('Scroll to top')),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            ContentPage(
              backgroundColor: Colors.white,
              stream: _streams[0],
            ),
            ContentPage(
              backgroundColor: Colors.deepOrange,
              stream: _streams[1],
            ),
            ContentPage(
              backgroundColor: Colors.green,
              stream: _streams[2],
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onTabTapped,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Messages'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
          ],
        ),
      ),
    );
  }

  Future<void> _onScrollsToTop(ScrollsToTopEvent event) async {
    _streams[_currentIndex].add(event);
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
