import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../presentation/providers/engine_provider.dart';

class GameLoop {
  final Ref ref;
  Ticker? _ticker;
  Duration _lastElapsed = Duration.zero;

  GameLoop(this.ref);

  void start() {
    if (_ticker == null) {
      _ticker = Ticker(_onTick);
      _ticker!.start();
    } else if (!_ticker!.isActive) {
      _ticker!.start();
      _lastElapsed = Duration.zero; // Reset to avoid jump after pause
    }
  }

  void stop() {
    _ticker?.stop();
    _lastElapsed = Duration.zero;
  }

  void _onTick(Duration elapsed) {
    if (_lastElapsed == Duration.zero) {
      _lastElapsed = elapsed;
      return;
    }
    double dt = (elapsed - _lastElapsed).inMicroseconds / 1000000.0;
    _lastElapsed = elapsed;

    // Cap dt to prevent massive jumps if framerate drops severely.
    // 0.1s cap means the game will visually slow down if it runs < 10 FPS,
    // protecting math formulas from massive integration errors.
    if (dt > 0.1) dt = 0.1;

    ref.read(engineProvider.notifier).tick(dt);
  }
}

final gameLoopProvider = Provider<GameLoop>((ref) {
  return GameLoop(ref);
});
