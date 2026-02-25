import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_void_protocol/presentation/providers/pipeline_provider.dart';
import 'package:the_void_protocol/presentation/providers/upgrades_provider.dart';

void main() {
  group('UpgradesNotifier Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('Initial state uses correctly calculated starting costs', () {
      final state = container.read(upgradesProvider);
      expect(state.generatorCount, equals(1));
      expect(state.filterCount, equals(1));
      expect(state.nextGeneratorCost, equals(11.5));
      expect(state.nextFilterCost, equals(60.0));
    });

    test('buyGenerator fails if signal is too low', () {
      // Base cost is 11.5, we provide 5.0
      container
          .read(pipelineProvider.notifier)
          .updateFromTick(addedNoise: 0, filterConsumed: 0, addedSignal: 5.0);
      bool success = container.read(upgradesProvider.notifier).buyGenerator();
      expect(success, isFalse);

      final state = container.read(upgradesProvider);
      expect(state.generatorCount, equals(1)); // Still 1
    });

    test('buyGenerator succeeds and escalates cost if signal is enough', () {
      // Base cost is 11.5, we provide 11.5
      container
          .read(pipelineProvider.notifier)
          .updateFromTick(addedNoise: 0, filterConsumed: 0, addedSignal: 11.5);
      bool success = container.read(upgradesProvider.notifier).buyGenerator();
      expect(success, isTrue);

      final state = container.read(upgradesProvider);
      expect(state.generatorCount, equals(2));
      // Next cost should be 10 * 1.15^2 = 13.225
      expect(state.nextGeneratorCost, closeTo(13.225, 0.001));
    });

    test('buyFilter succeeds and escalates cost if signal is enough', () {
      // Base filter cost is 60.0, we provide 100.0
      container
          .read(pipelineProvider.notifier)
          .updateFromTick(addedNoise: 0, filterConsumed: 0, addedSignal: 100.0);
      bool success = container.read(upgradesProvider.notifier).buyFilter();
      expect(success, isTrue);

      final state = container.read(upgradesProvider);
      expect(state.filterCount, equals(2));
      // Next cost should be 50 * 1.20^2 = 72.0
      expect(state.nextFilterCost, closeTo(72.0, 0.001));
    });
  });
}
