import 'package:flutter_test/flutter_test.dart';
import 'package:the_void_protocol/domain/entities/tech_tree.dart';
import 'package:the_void_protocol/domain/usecases/pipeline_calculator.dart';

void main() {
  group('PipelineCalculator', () {
    const TechTree defaultTree = TechTree();

    test('Generates noise properly based on generators and momentum', () {
      double noise = PipelineCalculator.calculateNoiseRate(
        baseProduction: 1.0,
        generatorCount: 10,
        currentMomentum: 1.5,
        techTree: defaultTree,
      );
      expect(noise, equals(15.0)); // 1.0 * 10 * 1.5
    });

    test('TechTree 3.1 Equipment Destruction 5x noise bonus', () {
      double noise = PipelineCalculator.calculateNoiseRate(
        baseProduction: 1.0,
        generatorCount: 10,
        currentMomentum: 1.0,
        techTree: defaultTree.copyWith(equilibriumDestructionUnlocked: true),
      );
      expect(noise, equals(50.0)); // 10 * 5x
    });

    test('Calculates filter capacity properly', () {
      double filterCapacity = PipelineCalculator.calculateFilterCapacity(
        baseCapacity: 10.0,
        filterCount: 5,
        generatorCount: 0,
        techTree: defaultTree,
      );
      expect(filterCapacity, equals(50.0));
    });

    test('TechTree 2.2 Echo Synergy adds 0.5% cap per 10 generators', () {
      double filterCapacity = PipelineCalculator.calculateFilterCapacity(
        baseCapacity: 10.0,
        filterCount: 1, // 10 cap
        generatorCount:
            20, // 20 / 10 = 2 sets -> 2 * 0.005 = 0.01 bonus -> 1% bonus
        techTree: defaultTree.copyWith(echoSynergyUnlocked: true),
      );
      expect(filterCapacity, equals(10.1)); // 10 + 1%
    });

    test('processTick processes normal signal creation without overheat', () {
      PipelineResult result = PipelineCalculator.processTick(
        dt: 1.0, // 1 second
        noiseRate: 10.0,
        filterRate: 20.0, // filter can handle 20
        filterEfficiency: 0.5,
        currentNoiseState: 0.0,
        isThrottling: false,
        techTree: defaultTree,
      );

      expect(result.noiseProduced, equals(10.0));
      expect(
        result.filterConsumed,
        equals(10.0),
      ); // Only consumes what is available (10)
      expect(result.signalProduced, equals(5.0)); // 10 * 0.5
      expect(
        result.overheatGenerated,
        equals(0.0),
      ); // noiseRate (10) < filterRate (20)
    });

    test('processTick generates overheat when noise > filter', () {
      PipelineResult result = PipelineCalculator.processTick(
        dt: 0.5, // half a second
        noiseRate: 20.0,
        filterRate: 10.0,
        filterEfficiency: 1.0,
        currentNoiseState: 0.0,
        isThrottling: false,
        techTree: defaultTree,
      );

      expect(result.noiseProduced, equals(10.0)); // 20 * 0.5
      expect(
        result.filterConsumed,
        equals(5.0),
      ); // filterRate(10) * dt(0.5) = 5
      expect(result.signalProduced, equals(5.0)); // 5 * 1.0
      expect(
        result.overheatGenerated,
        equals(5.0),
      ); // (20 - 10) * 0.5 dt = 5 overheat
    });

    test(
      'processTick severely limits production during Thermal Throttling',
      () {
        PipelineResult result = PipelineCalculator.processTick(
          dt: 1.0,
          noiseRate: 10.0,
          filterRate: 10.0,
          filterEfficiency: 1.0,
          currentNoiseState: 0.0,
          isThrottling: true, // THROTTLING ACTIVE
          techTree: defaultTree,
        );

        expect(result.filterConsumed, equals(1.0)); // filterRate * 0.1
        expect(
          result.signalProduced,
          equals(0.1),
        ); // filterConsumed(1) * activeEff(0.1)
      },
    );

    test('TechTree 3.1 Equilibrium Destruction multiplies signal by 5', () {
      PipelineResult result = PipelineCalculator.processTick(
        dt: 1.0,
        noiseRate: 10.0,
        filterRate: 10.0,
        filterEfficiency: 1.0,
        currentNoiseState: 0.0,
        isThrottling: false,
        techTree: defaultTree.copyWith(equilibriumDestructionUnlocked: true),
      );

      // Consumes 10 * 1.0 eff = 10, then * 5 = 50 signal
      expect(result.signalProduced, equals(50.0));
    });

    test(
      'TechTree 3.1 Equilibrium Destruction does NOT apply during Thermal Throttling',
      () {
        PipelineResult result = PipelineCalculator.processTick(
          dt: 1.0,
          noiseRate: 10.0,
          filterRate: 10.0,
          filterEfficiency: 1.0,
          currentNoiseState: 0.0,
          isThrottling: true, // THROTTLING ACTIVE
          techTree: defaultTree.copyWith(equilibriumDestructionUnlocked: true),
        );

        // Should act as normal throttling.
        // activeFilter = 10 * 0.1 = 1.0
        // activeEff = 1.0 * 0.1 = 0.1
        // base signal = 1.0 * 0.1 = 0.1
        // And the *5 multiplier should be ignored because isThrottling is true
        expect(result.signalProduced, closeTo(0.1, 0.001));
      },
    );
  });
}
