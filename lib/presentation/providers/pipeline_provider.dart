import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/awareness.dart';
import '../../domain/entities/noise.dart';
import '../../domain/entities/filter.dart';
import '../../domain/entities/signal.dart';
import '../../domain/entities/advanced_resources.dart';
import 'meta_provider.dart';

class PipelineState {
  final Noise noise;
  final Filter filter;
  final Signal signal;
  final Awareness awareness;

  // New Phase 2 Resources
  final ProcessedSignal processedSignal;
  final EncryptionKey encryptionKey;

  const PipelineState({
    this.noise = const Noise(),
    this.filter = const Filter(),
    this.signal = const Signal(),
    this.awareness = const Awareness(),
    this.processedSignal = const ProcessedSignal(),
    this.encryptionKey = const EncryptionKey(),
  });

  PipelineState copyWith({
    Noise? noise,
    Filter? filter,
    Signal? signal,
    Awareness? awareness,
    ProcessedSignal? processedSignal,
    EncryptionKey? encryptionKey,
  }) {
    return PipelineState(
      noise: noise ?? this.noise,
      filter: filter ?? this.filter,
      signal: signal ?? this.signal,
      awareness: awareness ?? this.awareness,
      processedSignal: processedSignal ?? this.processedSignal,
      encryptionKey: encryptionKey ?? this.encryptionKey,
    );
  }
}

class PipelineNotifier extends Notifier<PipelineState> {
  @override
  PipelineState build() {
    return const PipelineState();
  }

  void setInitialState(PipelineState loadedState) {
    state = loadedState;
  }

  // Updates from the game loop tick
  void updateFromTick({
    required double addedNoise,
    required double filterConsumed,
    required double addedSignal,
  }) {
    final meta = ref.read(metaProvider);

    if (meta.isCrashed) {
      // Production halted
      return;
    }

    // Process Advanced Resources if unlocked
    // For now, let's say 10% of raw Signal can be processed into ProcessedSignal if user has tech
    // This logic belongs in a Calculator usecase ideally, but for MVP here is fine.

    // Calculate final state
    state = state.copyWith(
      noise: state.noise.copyWith(
        currentAmount: state.noise.currentAmount + addedNoise - filterConsumed,
      ),
      signal: state.signal.copyWith(
        currentAmount: state.signal.currentAmount + addedSignal,
        lifetimeProduced: state.signal.lifetimeProduced + addedSignal,
      ),
    );
  }

  // Manual interaction
  void manualTap() {
    final meta = ref.read(metaProvider);
    if (meta.isCrashed) return;

    state = state.copyWith(
      noise: state.noise.copyWith(
        currentAmount: state.noise.currentAmount + 5.0,
      ),
    );

    // Manual tap adds heat
    ref.read(metaProvider.notifier).tick(0.0, addedHeat: 2.0);
  }

  // Deduct signal when purchasing upgrades
  void spendSignal(double amount) {
    if (state.signal.currentAmount >= amount) {
      state = state.copyWith(
        signal: state.signal.copyWith(
          currentAmount: state.signal.currentAmount - amount,
        ),
      );
    }
  }

  void reset() {
    state = const PipelineState();
  }
}

final pipelineProvider = NotifierProvider<PipelineNotifier, PipelineState>(() {
  return PipelineNotifier();
});
