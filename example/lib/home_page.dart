import 'package:example/content_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scroll to top')),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          ContentPage(
            backgroundColor: Colors.white,
            isOnScreen: _currentIndex == 0,
          ),
          ContentPage(
            backgroundColor: Colors.deepOrange,
            isOnScreen: _currentIndex == 1,
          ),
          ContentPage(
            backgroundColor: Colors.green,
            isOnScreen: _currentIndex == 2,
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
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
