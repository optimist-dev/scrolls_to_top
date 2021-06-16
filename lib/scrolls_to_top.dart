import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

typedef ScrollsToTopCallback = Future<void> Function(ScrollsToTopEvent event);

class ScrollsToTopEvent {
  ScrollsToTopEvent(
    this.to, {
    required this.duration,
    required this.curve,
  });

  final double to;
  final Duration duration;
  final Curve curve;
}

class ScrollsToTop extends StatefulWidget {
  const ScrollsToTop({
    Key? key,
    required this.child,
    required this.onScrollsToTop,
  }) : super(key: key);

  final Widget child;
  final ScrollsToTopCallback onScrollsToTop;

  @override
  State<ScrollsToTop> createState() => _ScrollsToTopState();
}

class _ScrollsToTopState extends State<ScrollsToTop> {
  ScrollController? _primaryScrollController;
  ScrollPositionWithSingleContext? _scrollPositionWithSingleContext;
  bool _attached = false;

  @override
  void dispose() {
    _scrollPositionWithSingleContext ??
        _primaryScrollController?.detach(_scrollPositionWithSingleContext!);
    _scrollPositionWithSingleContext?.dispose();
    _scrollPositionWithSingleContext = null;
    _primaryScrollController?.dispose();
    _primaryScrollController = null;
    _attached = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_attached) {
      _attach(context);
      _attached = true;
    }
    return widget.child;
  }

  void _attach(BuildContext context) {
    final primaryScrollController = PrimaryScrollController.of(context);
    if (primaryScrollController == null) return;

    final scrollPositionWithSingleContext =
        _FakeScrollPositionWithSingleContext(
      context: context,
      callback: widget.onScrollsToTop,
    );
    primaryScrollController.attach(scrollPositionWithSingleContext);

    _primaryScrollController = primaryScrollController;
    _scrollPositionWithSingleContext = scrollPositionWithSingleContext;
  }
}

class _FakeScrollPositionWithSingleContext
    extends ScrollPositionWithSingleContext {
  _FakeScrollPositionWithSingleContext({
    required BuildContext context,
    required ScrollsToTopCallback callback,
  })  : _onScrollsToTop = callback,
        super(
          physics: const NeverScrollableScrollPhysics(),
          context: _FakeScrollContext(context),
        );

  final ScrollsToTopCallback _onScrollsToTop;

  @override
  Future<void> animateTo(
    double to, {
    required Duration duration,
    required Curve curve,
  }) {
    return _onScrollsToTop(
      ScrollsToTopEvent(to, duration: duration, curve: curve),
    );
  }
}

class _FakeScrollContext extends ScrollContext {
  _FakeScrollContext(this._context);

  final BuildContext _context;

  @override
  AxisDirection get axisDirection => AxisDirection.down;

  @override
  BuildContext get notificationContext => _context;

  @override
  void saveOffset(double offset) {}

  @override
  void setCanDrag(bool value) {}

  @override
  void setIgnorePointer(bool value) {}

  @override
  void setSemanticsActions(Set<SemanticsAction> actions) {}

  @override
  BuildContext get storageContext => _context;

  @override
  TickerProvider get vsync => _FakeTickerProvider();
}

class _FakeTickerProvider extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
