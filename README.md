# Scrolls to top

[![pub package](https://img.shields.io/pub/v/scrolls_to_top.svg)](https://pub.dev/packages/scrolls_to_top)

A dart package for working with scrolls-to-top iOS feature

Why is this needed? 
This is necessary for those cases when you have several nested Scaffolds or you need to distinguish the tap event in the status bar from other scroll events

<img src="https://github.com/optimist-dev/scrolls_to_top/blob/main/arts/example.gif?raw=true">

## Usage

Just wrap any widget with `ScrollsToTop` and provide `onScrollsToTop` argument

```dart
  @override
  Widget build(BuildContext context) {
    return ScrollsToTop(
      onScrollsToTop: _onScrollsToTop,
      scaffold: Scaffold(
        appBar: AppBar(title: const Text('Scroll to top')),
        body: Container(),
      ),
    );
  }

  Future<void> _onScrollsToTop(ScrollsToTopEvent event) async {
    //TODO: Your code
  }
```

## Warning

- You need to have at least one Scaffold in your application
- If you use several Navigators, the tap events will come only to the widgets inside the main Navigator