import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      expect(state.generatorCount, equals(0));
      expect(state.filterCount, equals(0));
      expect(state.nextGeneratorCost, equals(10.0));
      expect(state.nextFilterCost, equals(50.0));
    });

    test('buyGenerator fails if awareness is too low', () {
      // Base cost is 10.0, we provide 5.0
      bool success = container
          .read(upgradesProvider.notifier)
          .buyGenerator(5.0);
      expect(success, isFalse);

      final state = container.read(upgradesProvider);
      expect(state.generatorCount, equals(0)); // Still 0
    });

    test('buyGenerator succeeds and escalates cost if awareness is enough', () {
      // Base cost is 10.0, we provide 10.0
      bool success = container
          .read(upgradesProvider.notifier)
          .buyGenerator(10.0);
      expect(success, isTrue);

      final state = container.read(upgradesProvider);
      expect(state.generatorCount, equals(1));
      // Next cost should be 10 * 1.15 = 11.5
      expect(state.nextGeneratorCost, equals(11.5));
    });

    test('buyFilter succeeds and escalates cost if awareness is enough', () {
      // Base filter cost is 50.0, we provide 100.0
      bool success = container.read(upgradesProvider.notifier).buyFilter(100.0);
      expect(success, isTrue);

      final state = container.read(upgradesProvider);
      expect(state.filterCount, equals(1));
      // Next cost should be 50 * 1.20 = 60.0
      expect(state.nextFilterCost, equals(60.0));
    });
  });
}
