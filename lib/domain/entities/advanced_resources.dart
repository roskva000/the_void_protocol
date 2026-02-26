class ProcessedSignal {
  final double currentAmount;
  final double lifetimeProduced;

  const ProcessedSignal({
    this.currentAmount = 0.0,
    this.lifetimeProduced = 0.0,
  });

  ProcessedSignal copyWith({
    double? currentAmount,
    double? lifetimeProduced,
  }) {
    return ProcessedSignal(
      currentAmount: currentAmount ?? this.currentAmount,
      lifetimeProduced: lifetimeProduced ?? this.lifetimeProduced,
    );
  }
}

class EncryptionKey {
  final int count;
  final int maxCapacity;

  const EncryptionKey({
    this.count = 0,
    this.maxCapacity = 10,
  });

  EncryptionKey copyWith({int? count, int? maxCapacity}) {
    return EncryptionKey(
      count: count ?? this.count,
      maxCapacity: maxCapacity ?? this.maxCapacity,
    );
  }
}
