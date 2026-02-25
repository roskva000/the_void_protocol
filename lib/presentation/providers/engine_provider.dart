import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/pipeline_calculator.dart';
import 'meta_provider.dart';
import 'pipeline_provider.dart';
import 'upgrades_provider.dart';

class EngineNotifier extends Notifier<double> {
  double _debugLogTimer = 0.0;

  @override
  double build() {
    return 0.0; // Initial dt
  }

  void tick(double dt) {
    state = dt;

    final metaState = ref.read(metaProvider);
    final upgradesState = ref.read(upgradesProvider);
    final pipelineState = ref.read(pipelineProvider);

    // 1. Calculate rates using O(1) mathematical domain logic
    double noiseRate = PipelineCalculator.calculateNoiseRate(
      baseProduction: pipelineState.noise.baseProductionPerSecond,
      generatorCount: upgradesState.generatorCount,
      currentMomentum: metaState.momentum,
      techTree: metaState.techTree,
    );

    double filterCapacity = PipelineCalculator.calculateFilterCapacity(
      baseCapacity: pipelineState.filter.baseCapacityPerSecond,
      filterCount: upgradesState.filterCount,
      generatorCount: upgradesState.generatorCount, // Echo Synergy connection
      techTree: metaState.techTree,
    );

    // 2. Process Tick
    PipelineResult tickResult = PipelineCalculator.processTick(
      dt: dt,
      noiseRate: noiseRate,
      filterRate: filterCapacity,
      filterEfficiency: pipelineState.filter.efficiency,
      currentNoiseState: pipelineState.noise.currentAmount,
      isThrottling: metaState.overheat.isThrottling,
      techTree: metaState.techTree,
    );

    // 3. Update Providers
    ref
        .read(pipelineProvider.notifier)
        .updateFromTick(
          addedNoise: tickResult.noiseProduced,
          filterConsumed: tickResult.filterConsumed,
          addedSignal: tickResult.signalProduced,
        );

    if (tickResult.overheatGenerated > 0) {
      ref
          .read(metaProvider.notifier)
          .updateOverheat(tickResult.overheatGenerated);
    }

    // Momentum decay (if applicable)
    ref.read(metaProvider.notifier).decayMomentum(dt);

    // 4. Debug Logic (Temporary for Phase 4 Verification)
    if (kDebugMode) {
      _debugLogTimer += dt;
      if (_debugLogTimer >= 1.0) {
        // We read updated state to print correctly
        final newPipelineState = ref.read(pipelineProvider);
        debugPrint(
          '--- TICK 1s --- Noise: ${newPipelineState.noise.currentAmount.toStringAsFixed(1)} | Signal: ${newPipelineState.signal.currentAmount.toStringAsFixed(1)} | Gens: ${upgradesState.generatorCount}',
        );
        _debugLogTimer -= 1.0;
      }
    }
  }
}

final engineProvider = NotifierProvider<EngineNotifier, double>(() {
  return EngineNotifier();
});
