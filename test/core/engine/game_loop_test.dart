import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_void_protocol/core/engine/game_loop.dart';
import 'package:the_void_protocol/presentation/providers/pipeline_provider.dart';
import 'package:the_void_protocol/presentation/providers/upgrades_provider.dart';

class TestApp extends ConsumerWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Start the game loop
    ref.read(gameLoopProvider).start();

    // Provide a button to "buy" a generator for test purposes
    return MaterialApp(
      home: Scaffold(
        body: ElevatedButton(
          key: const Key('buy_gen'),
          onPressed: () {
            // Give enough fake awareness just for test
            ref
                .read(pipelineProvider.notifier)
                .updateFromTick(
                  addedNoise: 0,
                  filterConsumed: 0,
                  addedSignal: 100.0,
                );
            ref.read(upgradesProvider.notifier).buyGenerator(100.0);
          },
          child: const Text('Buy Gen'),
        ),
      ),
    );
  }
}

void main() {
  testWidgets('GameLoop ticks and progresses pipeline math', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: TestApp()));

    // Tap to buy generator so production starts
    await tester.tap(find.byKey(const Key('buy_gen')));
    await tester.pump();

    // Pump time by 1 second (1000ms)
    // Ticker needs multiple frames to register dt elapsed
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump(const Duration(milliseconds: 950));

    final element = tester.element(find.byType(TestApp));
    final container = ProviderScope.containerOf(element);

    final pipelineState = container.read(pipelineProvider);

    // With at least 1 generator and 1 filter, and 1 second elapsed, signal should be > 0
    // because the filter consumes the produced noise immediately.
    expect(pipelineState.signal.currentAmount, greaterThan(0));

    // Stop the loop to avoid dangling tickers
    container.read(gameLoopProvider).stop();
  });
}
