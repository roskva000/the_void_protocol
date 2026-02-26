class NarrativeEvent {
  final String id;
  final String message;
  final bool isUnique;
  final double? noiseThreshold; // Trigger when noise exceeds this
  final double? signalThreshold; // Trigger when signal exceeds this
  final double? awarenessThreshold; // Trigger when awareness exceeds this
  final bool isGlitched; // Should the text be visually corrupted?

  const NarrativeEvent({
    required this.id,
    required this.message,
    this.isUnique = true,
    this.noiseThreshold,
    this.signalThreshold,
    this.awarenessThreshold,
    this.isGlitched = false,
  });
}
