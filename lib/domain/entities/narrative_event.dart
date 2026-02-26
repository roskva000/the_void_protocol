class NarrativeEvent {
  final String id;
  final String message;
  final NarrativeTrigger trigger;
  final bool isOneShot;
  final int priority; // Higher means more important
  final Duration delay; // Delay after trigger before showing
  final bool isGlitched;

  const NarrativeEvent({
    required this.id,
    required this.message,
    required this.trigger,
    this.isOneShot = true,
    this.priority = 0,
    this.delay = Duration.zero,
    this.isGlitched = false,
  });
}

enum TriggerType {
  resourceThreshold,
  timeElapsed,
  manualAction,
  techUnlocked,
  custom,
}

class NarrativeTrigger {
  final TriggerType type;
  final String? targetId; // Resource ID or Tech ID
  final double value; // Threshold value

  const NarrativeTrigger({required this.type, this.targetId, this.value = 0.0});
}
