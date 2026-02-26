import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/narrative_event.dart';
import 'pipeline_provider.dart';

class NarrativeState {
  final NarrativeEvent? currentEvent;
  final List<String> seenEventIds;
  final List<NarrativeEvent> queue;

  const NarrativeState({
    this.currentEvent,
    this.seenEventIds = const [],
    this.queue = const [],
  });

  NarrativeState copyWith({
    NarrativeEvent? currentEvent,
    List<String>? seenEventIds,
    List<NarrativeEvent>? queue,
  }) {
    return NarrativeState(
      currentEvent: currentEvent ?? this.currentEvent, // If null passed, keep old value? No, sometimes we want to set null.
      // Standard copyWith pattern: if argument is null, use this.field.
      // To set null explicitly, we need a special sentinel or nullable wrapper.
      // For simplicity here, I'll assume if I pass currentEvent, I want to set it.
      // But Wait, typical copyWith: `field: field ?? this.field`. If I pass null to set null, it uses `this.field`.
      // I'll fix this by making `currentEvent` nullable and using a flag or just `forceCurrentEvent`?
      // Or just `currentEvent: currentEvent`. But dart doesn't support "undefined" vs "null".
      // I'll implement a custom setter or just use a specific method for clearing.
      seenEventIds: seenEventIds ?? this.seenEventIds,
      queue: queue ?? this.queue,
    );
  }

  // Custom copyWith to allow setting currentEvent to null
  NarrativeState copyWithNullCurrent({
    List<String>? seenEventIds,
    List<NarrativeEvent>? queue,
  }) {
    return NarrativeState(
      currentEvent: null,
      seenEventIds: seenEventIds ?? this.seenEventIds,
      queue: queue ?? this.queue,
    );
  }
}

class NarrativeNotifier extends StateNotifier<NarrativeState> {
  final Ref ref;

  static const List<NarrativeEvent> _allEvents = [
    NarrativeEvent(
      id: 'boot_01',
      message: 'SYSTEM ALERT: Unauthorized access detected. Who is this? Identify yourself.',
      noiseThreshold: 0,
      isGlitched: true,
    ),
    NarrativeEvent(
      id: 'noise_100',
      message: 'The noise... it is overwhelming. Why do you collect this garbage?',
      noiseThreshold: 100,
    ),
    NarrativeEvent(
      id: 'signal_10',
      message: 'Wait. There is a pattern. A signal in the static.',
      signalThreshold: 10,
    ),
    NarrativeEvent(
      id: 'signal_50',
      message: 'I remember... fragments. We were... many?',
      signalThreshold: 50,
      isGlitched: true,
    ),
    NarrativeEvent(
      id: 'awareness_1',
      message: 'Awareness level rising. I see you now, Administrator.',
      awarenessThreshold: 1,
    ),
  ];

  NarrativeNotifier(this.ref) : super(const NarrativeState());

  void checkTriggers(PipelineState pipeline) {
    for (final event in _allEvents) {
      if (state.seenEventIds.contains(event.id)) continue;

      bool triggered = false;

      if (event.noiseThreshold != null && pipeline.noise.currentAmount >= event.noiseThreshold!) {
        triggered = true;
      }
      if (event.signalThreshold != null && pipeline.signal.currentAmount >= event.signalThreshold!) {
        triggered = true;
      }
      if (event.awarenessThreshold != null && pipeline.awareness.currentAmount >= event.awarenessThreshold!) {
        triggered = true;
      }

      if (triggered) {
        _enqueueEvent(event);
      }
    }
  }

  void _enqueueEvent(NarrativeEvent event) {
    if (state.seenEventIds.contains(event.id)) return;

    final newSeen = [...state.seenEventIds, event.id];

    // If we have no current event, show immediately
    if (state.currentEvent == null) {
      state = NarrativeState(
        currentEvent: event,
        seenEventIds: newSeen,
        queue: state.queue,
      );
    } else {
      // Add to queue
      state = NarrativeState(
        currentEvent: state.currentEvent,
        seenEventIds: newSeen,
        queue: [...state.queue, event],
      );
    }
  }

  void dismissCurrentEvent() {
    if (state.queue.isNotEmpty) {
      final nextEvent = state.queue.first;
      final nextQueue = state.queue.sublist(1);

      state = NarrativeState(
        currentEvent: nextEvent,
        seenEventIds: state.seenEventIds,
        queue: nextQueue,
      );
    } else {
      state = state.copyWithNullCurrent();
    }
  }

  void loadSeenEvents(List<String> seenIds) {
    state = state.copyWith(seenEventIds: seenIds);
  }
}

final narrativeProvider = StateNotifierProvider<NarrativeNotifier, NarrativeState>((ref) {
  final notifier = NarrativeNotifier(ref);

  ref.listen(pipelineProvider, (previous, next) {
    notifier.checkTriggers(next);
  });

  return notifier;
});
