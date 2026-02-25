import 'package:flutter/widgets.dart';

class LifecycleObserver extends WidgetsBindingObserver {
  final VoidCallback onPaused;
  final VoidCallback onResumed;

  LifecycleObserver({required this.onPaused, required this.onResumed});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      onPaused();
    } else if (state == AppLifecycleState.resumed) {
      onResumed();
    }
  }

  void setup() {
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
