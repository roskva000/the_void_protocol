import '../../domain/entities/tech_tree.dart';
import '../../domain/usecases/pipeline_calculator.dart';

class OfflineProgressResult {
  final double noiseProduced;
  final double filterConsumed;
  final double signalProduced;
  final double overheatGenerated;
  final int secondsElapsed;

  const OfflineProgressResult({
    required this.noiseProduced,
    required this.filterConsumed,
    required this.signalProduced,
    required this.overheatGenerated,
    required this.secondsElapsed,
  });
}

class OfflineProgressRepository {
  /// Calculates offline progress by acting as a single giant "tick" where `dt` is the offline time.
  /// This adheres back to the O(1) mathematical philosophy of the project.
  OfflineProgressResult calculateOfflineProgress({
    required DateTime lastExitTime,
    required DateTime resumeTime,
    required double baseNoiseProduction,
    required int generatorCount,
    required double baseFilterCapacity,
    required int filterCount,
    required double filterEfficiency,
    required double currentNoiseState,
    required bool isThrottling,
    required TechTree techTree,
  }) {
    int secondsElapsed = resumeTime.difference(lastExitTime).inSeconds;

    if (secondsElapsed <= 0) {
      return const OfflineProgressResult(
        noiseProduced: 0,
        filterConsumed: 0,
        signalProduced: 0,
        overheatGenerated: 0,
        secondsElapsed: 0,
      );
    }

    // Tree 1.1 Quantum Sleep - Boosts offline efficiency.
    // Base offline efficiency is typically 15%, but Quantum Sleep makes it 50%.
    double offlineEfficiency = techTree.quantumSleepUnlocked ? 0.50 : 0.15;

    // Convert elapsed time to a dt representing the "active" time equivalent
    double effectiveDt = secondsElapsed * offlineEfficiency;

    // We calculate the rates using purely offline values.
    // Momentum is dropped to 1.0 offline.
    double noiseRate = PipelineCalculator.calculateNoiseRate(
      baseProduction: baseNoiseProduction,
      generatorCount: generatorCount,
      currentMomentum: 1.0,
      techTree: techTree,
    );

    double filterCapacityRate = PipelineCalculator.calculateFilterCapacity(
      baseCapacity: baseFilterCapacity,
      filterCount: filterCount,
      generatorCount: generatorCount,
      techTree: techTree,
    );

    // Run the macroscopic O(1) integral calculation.
    PipelineResult macroTick = PipelineCalculator.processTick(
      dt: effectiveDt,
      noiseRate: noiseRate,
      filterRate: filterCapacityRate,
      filterEfficiency: filterEfficiency,
      currentNoiseState: currentNoiseState,
      isThrottling: isThrottling,
      techTree: techTree,
    );

    return OfflineProgressResult(
      noiseProduced: macroTick.noiseProduced,
      filterConsumed: macroTick.filterConsumed,
      signalProduced: macroTick.signalProduced,
      overheatGenerated: macroTick.overheatGenerated,
      secondsElapsed: secondsElapsed,
    );
  }
}
