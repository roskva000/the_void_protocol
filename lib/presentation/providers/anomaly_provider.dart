import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/anomaly_event.dart';
import '../../presentation/providers/terminal_provider.dart';
import 'sound_provider.dart';
import 'haptic_provider.dart';

class AnomalyNotifier extends Notifier<AnomalyEvent> {
  Timer? _checkTimer;
  final Random _rng = Random();

  @override
  AnomalyEvent build() {
    // Check every 10 seconds
    _checkTimer = Timer.periodic(const Duration(seconds: 10), (_) => _checkSpawn());

    ref.onDispose(() {
      _checkTimer?.cancel();
    });

    return AnomalyEvent(startTime: DateTime.now());
  }

  void _checkSpawn() {
    if (state.isActive) return;

    // 5% chance every 10 seconds to spawn an anomaly
    if (_rng.nextDouble() < 0.05) {
      _spawnAnomaly();
    }
  }

  void _spawnAnomaly() {
    // For now, always firewall breach
    const type = AnomalyType.firewallBreach;

    state = AnomalyEvent(
      type: type,
      startTime: DateTime.now(),
      duration: const Duration(seconds: 60),
      isActive: true,
      penaltyMultiplier: 0.5,
    );

    // Notify user
    ref.read(soundProvider).play('alarm');
    ref.read(hapticProvider).error();
    ref.read(terminalProvider.notifier).addLine(
      "CRITICAL WARNING: ANOMALY DETECTED [${type.name.toUpperCase()}]",
      LineType.error
    );
  }

  void resolveAnomaly() {
    if (!state.isActive) return;

    ref.read(terminalProvider.notifier).addLine(
      "ANOMALY PURGED. SYSTEMS RESTORING...",
      LineType.success
    );

    ref.read(soundProvider).play('powerup');
    ref.read(hapticProvider).success();

    state = state.copyWith(isActive: false, penaltyMultiplier: 1.0);
  }
}

final anomalyProvider = NotifierProvider<AnomalyNotifier, AnomalyEvent>(() {
  return AnomalyNotifier();
});
