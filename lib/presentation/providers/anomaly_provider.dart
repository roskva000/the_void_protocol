import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import '../../domain/entities/anomaly.dart';
import 'meta_provider.dart';
import 'pipeline_provider.dart';

class AnomalyState {
  final Anomaly? activeAnomaly;
  final double timeRemaining;

  const AnomalyState({
    this.activeAnomaly,
    this.timeRemaining = 0.0,
  });

  AnomalyState copyWith({
    Anomaly? activeAnomaly,
    double? timeRemaining,
  }) {
    return AnomalyState(
      activeAnomaly: activeAnomaly, // Nullable, so if not passed, keeps current. But we want to be able to set to null.
      // Wait, copyWith usually takes nullable arguments to update, so if I pass null, it means "don't update".
      // I need a way to clear it. I'll use a specific logic.
      timeRemaining: timeRemaining ?? this.timeRemaining,
    );
  }
}

// I'll just use a direct copyWith that handles nulls properly if I need to clear.
// Actually, standard copyWith pattern:
// activeAnomaly: activeAnomaly ?? this.activeAnomaly
// doesn't allow setting to null.
// I'll rewrite copyWith to allow clearing.

class AnomalyNotifier extends Notifier<AnomalyState> {
  final Random _rng = Random();

  @override
  AnomalyState build() {
    return const AnomalyState();
  }

  void tick(double dt) {
    // If anomaly is active, tick down
    if (state.activeAnomaly != null) {
      double newTime = state.timeRemaining - dt;
      if (newTime <= 0) {
        failAnomaly();
      } else {
        state = AnomalyState(
          activeAnomaly: state.activeAnomaly,
          timeRemaining: newTime,
        );
      }
      return;
    }

    // Chance to spawn anomaly
    // Base chance: 0.1% per second? (Very low)
    // Increases with Heat and Noise.
    final meta = ref.read(metaProvider);
    if (meta.isCrashed) return; // No anomalies during crash (already bad enough)

    final heat = meta.overheat.currentPool;
    final noise = ref.read(pipelineProvider).noise.currentAmount;

    // Simple logic:
    // If Heat > 50, chance increases.
    // If Noise > 1000, chance increases.

    // Base probability per second
    double spawnRate = 0.005; // 0.5% per second base
    if (heat > 50) spawnRate += 0.01; // +1% per second
    if (heat > 80) spawnRate += 0.05; // +5% per second
    if (noise > 1000) spawnRate += 0.02; // +2% per second

    // Adjust for dt to get probability per tick
    if (_rng.nextDouble() < spawnRate * dt) {
      spawnAnomaly();
    }
  }

  void spawnAnomaly() {
    if (state.activeAnomaly != null) return; // Don't overwrite existing

    // Pick random type
    final type = _rng.nextInt(3);
    Anomaly anomaly;

    switch (type) {
      case 0:
        anomaly = const Anomaly(
          id: 'data_corruption',
          title: 'Data Corruption',
          description: 'Noise levels critical. Purge required.',
          severity: 1,
          timeToResolve: 15.0,
          isActive: true,
        );
        break;
      case 1:
        anomaly = const Anomaly(
          id: 'void_leak',
          title: 'Void Leak',
          description: 'Core stability failing. Seal the breach.',
          severity: 2,
          timeToResolve: 10.0,
          isActive: true,
        );
        break;
      default:
        anomaly = const Anomaly(
          id: 'temporal_rift',
          title: 'Temporal Rift',
          description: 'Time dilation detected. Synchronize immediately.',
          severity: 3,
          timeToResolve: 8.0,
          isActive: true,
        );
    }

    state = AnomalyState(
      activeAnomaly: anomaly,
      timeRemaining: anomaly.timeToResolve,
    );
  }

  void resolveAnomaly() {
    if (state.activeAnomaly == null) return;

    // Reward
    final anomaly = state.activeAnomaly!;
    if (anomaly.id == 'void_leak') {
      ref.read(metaProvider.notifier).restoreStability(0.2);
    } else {
      ref.read(pipelineProvider.notifier).updateFromTick(
        addedNoise: -100, // Clear some noise
        filterConsumed: 0,
        addedSignal: 500 * anomaly.severity.toDouble(),
      );
    }

    // Clear
    state = const AnomalyState();
  }

  void failAnomaly() {
    if (state.activeAnomaly == null) return;

    // Punishment
    final anomaly = state.activeAnomaly!;
    // Damage stability
    double damage = 0.1 * anomaly.severity;
    ref.read(metaProvider.notifier).restoreStability(-damage);

    // Add heat
    ref.read(metaProvider.notifier).tick(0, addedHeat: 10.0 * anomaly.severity);

    // Clear
    state = const AnomalyState();
  }
}

final anomalyProvider = NotifierProvider<AnomalyNotifier, AnomalyState>(() {
  return AnomalyNotifier();
});
