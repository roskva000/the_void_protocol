import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_void_protocol/presentation/providers/pipeline_provider.dart';

void main() {
  group('PipelineNotifier Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('updateFromTick correctly updates noise and signal amounts', () {
      final notifier = container.read(pipelineProvider.notifier);

      // Simulate a tick: 5.0 noise added, 2.0 consumed by filter, 1.0 signal produced
      notifier.updateFromTick(
        addedNoise: 5.0,
        filterConsumed: 2.0,
        addedSignal: 1.0,
      );

      final state = container.read(pipelineProvider);

      expect(state.noise.currentAmount, equals(3.0)); // 0 + 5 - 2 = 3
      expect(state.signal.currentAmount, equals(1.0)); // 0 + 1 = 1
      expect(state.signal.lifetimeProduced, equals(1.0)); // 0 + 1 = 1
    });
  });
}
