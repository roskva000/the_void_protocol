import 'package:hive/hive.dart';

part 'save_data_model.g.dart';

@HiveType(typeId: 0)
class SaveDataModel extends HiveObject {
  @HiveField(0)
  final double noiseAmount;

  @HiveField(1)
  final double signalAmount;

  @HiveField(2)
  final double awarenessAmount;

  @HiveField(3)
  final double overheatPool;

  @HiveField(4)
  final int generatorCount;

  @HiveField(5)
  final int filterCount;

  @HiveField(6)
  final DateTime? lastExitTime;

  // Tech Tree Unlocks
  @HiveField(7)
  final bool quantumSleepUnlocked;
  @HiveField(8)
  final bool perfectIsolationUnlocked;
  @HiveField(9)
  final bool infiniteLoopUnlocked;
  @HiveField(10)
  final bool autoPurgeUnlocked;

  @HiveField(11)
  final bool voiceOfHumanityUnlocked;
  @HiveField(12)
  final bool echoSynergyUnlocked;
  @HiveField(13)
  final bool memoryRestorationUnlocked;
  @HiveField(14)
  final bool ethicsCoreUnlocked;

  @HiveField(15)
  final bool equilibriumDestructionUnlocked;
  @HiveField(16)
  final bool resonanceCoreUnlocked;
  @HiveField(17)
  final bool quantumOverclockUnlocked;
  @HiveField(18)
  final bool destructiveWillUnlocked;

  // New Advanced Resources
  @HiveField(19)
  final double processedSignalAmount;

  @HiveField(20)
  final int encryptionKeyCount;

  SaveDataModel({
    required this.noiseAmount,
    required this.signalAmount,
    required this.awarenessAmount,
    required this.overheatPool,
    required this.generatorCount,
    required this.filterCount,
    this.lastExitTime,
    this.quantumSleepUnlocked = false,
    this.perfectIsolationUnlocked = false,
    this.infiniteLoopUnlocked = false,
    this.autoPurgeUnlocked = false,
    this.voiceOfHumanityUnlocked = false,
    this.echoSynergyUnlocked = false,
    this.memoryRestorationUnlocked = false,
    this.ethicsCoreUnlocked = false,
    this.equilibriumDestructionUnlocked = false,
    this.resonanceCoreUnlocked = false,
    this.quantumOverclockUnlocked = false,
    this.destructiveWillUnlocked = false,
    this.processedSignalAmount = 0.0,
    this.encryptionKeyCount = 0,
  });
}
