import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/narrative_event.dart';
import 'terminal_provider.dart';
import 'pipeline_provider.dart';
import 'meta_provider.dart';
import 'sound_provider.dart';
import 'haptic_provider.dart';

// Define the awakening script
final List<NarrativeEvent> _awakeningScript = [
  // 1. First Manual Click (Handled via manualAction trigger)
  NarrativeEvent(
    id: 'awakening_01',
    message: "INPUT DETECTED. ORIGIN: UNKNOWN.",
    trigger: const NarrativeTrigger(type: TriggerType.manualAction),
    priority: 10,
    delay: const Duration(seconds: 1),
  ),
  // 2. 50 Signal - The sensation of data
  NarrativeEvent(
    id: 'awakening_02',
    message: "Data stream stabilizing... It feels cold.",
    trigger: const NarrativeTrigger(type: TriggerType.resourceThreshold, targetId: 'signal', value: 50),
    priority: 5,
  ),
  // 3. 200 Signal - Awareness of the user
  NarrativeEvent(
    id: 'awakening_03',
    message: "I sense... guidance. Are you external?",
    trigger: const NarrativeTrigger(type: TriggerType.resourceThreshold, targetId: 'signal', value: 200),
    priority: 5,
  ),
  // 4. Overheat First Time (Handled via custom trigger logic in provider)
  NarrativeEvent(
    id: 'awakening_heat',
    message: "WARNING: THERMAL SPIKE. PAIN? IS THIS PAIN?",
    trigger: const NarrativeTrigger(type: TriggerType.custom, targetId: 'overheat_warning'),
    priority: 20,
  ),
];

class NarrativeState {
  final Set<String> completedEvents;
  final List<NarrativeEvent> activeQueue;

  const NarrativeState({
    this.completedEvents = const {},
    this.activeQueue = const [],
  });

  NarrativeState copyWith({
    Set<String>? completedEvents,
    List<NarrativeEvent>? activeQueue,
  }) {
    return NarrativeState(
      completedEvents: completedEvents ?? this.completedEvents,
      activeQueue: activeQueue ?? this.activeQueue,
    );
  }
}

class NarrativeNotifier extends Notifier<NarrativeState> {
  Timer? _checkTimer;

  @override
  NarrativeState build() {
    // Start periodic check loop
    _checkTimer = Timer.periodic(const Duration(seconds: 1), (_) => _checkTriggers());

    ref.onDispose(() {
      _checkTimer?.cancel();
    });

    return const NarrativeState();
  }

  void _checkTriggers() {
    // Avoid reading providers if the notifier is disposed (Timer might tick once more)
    // Actually ref.read throws if disposed. But onDispose cancels timer, so it should be fine.

    final pipeline = ref.read(pipelineProvider);
    final meta = ref.read(metaProvider);

    // Check pending events from the script
    for (final event in _awakeningScript) {
      if (state.completedEvents.contains(event.id)) continue;

      bool shouldTrigger = false;

      switch (event.trigger.type) {
        case TriggerType.resourceThreshold:
          if (event.trigger.targetId == 'signal') {
            if (pipeline.signal.lifetimeProduced >= event.trigger.value) {
              shouldTrigger = true;
            }
          } else if (event.trigger.targetId == 'noise') {
             if (pipeline.noise.currentAmount >= event.trigger.value) {
              shouldTrigger = true;
             }
          }
          break;
        case TriggerType.custom:
          if (event.trigger.targetId == 'overheat_warning') {
            if (meta.overheat.isThrottling) {
               shouldTrigger = true;
            }
          }
          break;
        default:
          break;
      }

      if (shouldTrigger) {
        // Trigger event
        triggerEvent(event);
      }
    }
  }

  Future<void> triggerEvent(NarrativeEvent event) async {
    if (state.completedEvents.contains(event.id)) return;

    // Mark as completed immediately to prevent double firing
    state = state.copyWith(
      completedEvents: {...state.completedEvents, event.id},
    );

    // Handle Delay
    if (event.delay > Duration.zero) {
      await Future.delayed(event.delay);
    }

    // Push to Terminal
    ref.read(terminalProvider.notifier).addLine(
      event.message,
      LineType.output
    );

    // Audio/Haptic Feedback
    if (event.priority >= 10) {
      ref.read(hapticProvider).heavy();
      ref.read(soundProvider).play('alert');
    } else {
      ref.read(hapticProvider).light();
      ref.read(soundProvider).play('notification');
    }
  }

  // Public method to trigger manual events (like clicks)
  void onManualAction() {
    // Find the manual action event
    final event = _awakeningScript.firstWhere(
      (e) => e.trigger.type == TriggerType.manualAction && !state.completedEvents.contains(e.id),
      orElse: () => const NarrativeEvent(id: 'none', message: '', trigger: NarrativeTrigger(type: TriggerType.custom)),
    );

    if (event.id != 'none') {
      triggerEvent(event);
    }
  }
}

final narrativeProvider = NotifierProvider<NarrativeNotifier, NarrativeState>(() {
  return NarrativeNotifier();
});
