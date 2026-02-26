import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShakeEvent {
  final double intensity;
  final Duration duration;
  final DateTime timestamp;

  ShakeEvent({
    required this.intensity,
    required this.duration,
  }) : timestamp = DateTime.now();
}

class ShakeNotifier extends Notifier<ShakeEvent?> {
  @override
  ShakeEvent? build() {
    return null;
  }

  void trigger({double intensity = 1.0, Duration duration = const Duration(milliseconds: 500)}) {
    state = ShakeEvent(intensity: intensity, duration: duration);
  }
}

final shakeProvider = NotifierProvider<ShakeNotifier, ShakeEvent?>(() {
  return ShakeNotifier();
});
