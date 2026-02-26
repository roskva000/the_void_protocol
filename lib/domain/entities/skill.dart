class Skill {
  final String id;
  final String name;
  final String description;
  final double cooldownTime; // in seconds
  final double cost; // Cost value
  final String costType; // "Stability", "Signal", "Overheat"
  final bool isUnlocked;

  const Skill({
    required this.id,
    required this.name,
    required this.description,
    required this.cooldownTime,
    required this.cost,
    required this.costType,
    this.isUnlocked = false,
  });

  Skill copyWith({
    bool? isUnlocked,
  }) {
    return Skill(
      id: id,
      name: name,
      description: description,
      cooldownTime: cooldownTime,
      cost: cost,
      costType: costType,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }
}
