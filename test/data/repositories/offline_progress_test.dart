import 'package:flutter_test/flutter_test.dart';
import 'package:the_void_protocol/data/repositories/offline_progress_repository.dart';
import 'package:the_void_protocol/domain/entities/tech_tree.dart';

void main() {
  group('OfflineProgressRepository', () {
    late OfflineProgressRepository repository;
    const TechTree defaultTree = TechTree();

    setUp(() {
      repository = OfflineProgressRepository();
    });

    test('calculates correct progress for 10 hour gap (36000 seconds)', () {
      final now = DateTime.now();
      final tenHoursAgo = now.subtract(const Duration(hours: 10));

      // Simulate player state: 10 generators, 5 filters.
      final result = repository.calculateOfflineProgress(
        lastExitTime: tenHoursAgo,
        resumeTime: now,
        baseNoiseProduction: 1.0,
        generatorCount: 10, // 10 hz raw
        baseFilterCapacity: 10.0,
        filterCount: 2, // 20 capacity
        filterEfficiency: 0.5,
        currentNoiseState: 0.0,
        isThrottling: false,
        techTree: defaultTree,
      );

      // elapsed = 36000 seconds
      expect(result.secondsElapsed, equals(36000));

      // Effective dt for standard 15% efficiency (0.15 * 36000) = 5400 "active" seconds
      double expectedDt = 36000 * 0.15;
      expect(expectedDt, equals(5400));

      // Noise Rate = 1(base) * 10(gens) * 1.0(mom) = 10
      // Noise Produced = 10 * 5400 = 54000
      expect(result.noiseProduced, equals(54000.0));

      // Filter Capacity = 20
      // 20 > 10, so bottleneck is noise.
      // Noise Consumed = 54000
      expect(result.filterConsumed, equals(54000.0));

      // Signal = 54000 * 0.5 = 27000
      expect(result.signalProduced, equals(27000.0));

      // Overheat generating rate: 10 - 20 = -10 (no overheat, should be 0)
      expect(result.overheatGenerated, equals(0.0));
    });

    test(
      'calculates correct progress with Quantum Sleep Tech (50% efficiency)',
      () {
        final now = DateTime.now();
        final tenHoursAgo = now.subtract(const Duration(hours: 10));

        final TechTree quantumTree = defaultTree.copyWith(
          quantumSleepUnlocked: true,
        );

        final result = repository.calculateOfflineProgress(
          lastExitTime: tenHoursAgo,
          resumeTime: now,
          baseNoiseProduction: 1.0,
          generatorCount: 10,
          baseFilterCapacity: 10.0,
          filterCount: 2,
          filterEfficiency: 0.5,
          currentNoiseState: 0.0,
          isThrottling: false,
          techTree: quantumTree,
        );

        // Effective dt = 36000 * 0.50 = 18000
        // Noise Rate = 10. Produced = 180000
        expect(result.noiseProduced, equals(180000.0));
        expect(result.signalProduced, equals(90000.0));
      },
    );
  });
}
