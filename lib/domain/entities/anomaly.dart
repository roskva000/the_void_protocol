class Anomaly {
  final String id;
  final String title;
  final String description;
  final int severity; // 1-3
  final double timeToResolve; // Seconds before failure
  final bool isActive;

  const Anomaly({
    required this.id,
    required this.title,
    required this.description,
    required this.severity,
    required this.timeToResolve,
    this.isActive = false,
  });

  Anomaly copyWith({
    bool? isActive,
    double? timeToResolve,
  }) {
    return Anomaly(
      id: id,
      title: title,
      description: description,
      severity: severity,
      timeToResolve: timeToResolve ?? this.timeToResolve,
      isActive: isActive ?? this.isActive,
    );
  }
}
