enum AnomalyType {
  firewallBreach,
  dataCorruption,
  signalLeak,
  none,
}

class AnomalyEvent {
  final AnomalyType type;
  final DateTime startTime;
  final Duration duration;
  final bool isActive;
  final double penaltyMultiplier; // 0.5 = 50% production

  const AnomalyEvent({
    this.type = AnomalyType.none,
    required this.startTime,
    this.duration = const Duration(seconds: 30),
    this.isActive = false,
    this.penaltyMultiplier = 1.0,
  });

  AnomalyEvent copyWith({
    AnomalyType? type,
    DateTime? startTime,
    Duration? duration,
    bool? isActive,
    double? penaltyMultiplier,
  }) {
    return AnomalyEvent(
      type: type ?? this.type,
      startTime: startTime ?? this.startTime,
      duration: duration ?? this.duration,
      isActive: isActive ?? this.isActive,
      penaltyMultiplier: penaltyMultiplier ?? this.penaltyMultiplier,
    );
  }
}
