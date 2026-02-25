import 'package:hive_flutter/hive_flutter.dart';

class SaveDataModel {
  final double noiseAmount;
  final double signalAmount;
  final double awarenessAmount;
  final double overheatPool;
  final int generatorCount;
  final int filterCount;
  final DateTime? lastExitTime;

  // Tech Tree Unlocks
  final bool quantumSleepUnlocked;
  final bool perfectIsolationUnlocked;
  final bool infiniteLoopUnlocked;
  final bool autoPurgeUnlocked;

  final bool voiceOfHumanityUnlocked;
  final bool echoSynergyUnlocked;
  final bool memoryRestorationUnlocked;
  final bool ethicsCoreUnlocked;

  final bool equilibriumDestructionUnlocked;
  final bool resonanceCoreUnlocked;
  final bool quantumOverclockUnlocked;
  final bool destructiveWillUnlocked;

  const SaveDataModel({
    required this.noiseAmount,
    required this.signalAmount,
    required this.awarenessAmount,
    required this.overheatPool,
    required this.generatorCount,
    required this.filterCount,
    this.lastExitTime,
    required this.quantumSleepUnlocked,
    required this.perfectIsolationUnlocked,
    required this.infiniteLoopUnlocked,
    required this.autoPurgeUnlocked,
    required this.voiceOfHumanityUnlocked,
    required this.echoSynergyUnlocked,
    required this.memoryRestorationUnlocked,
    required this.ethicsCoreUnlocked,
    required this.equilibriumDestructionUnlocked,
    required this.resonanceCoreUnlocked,
    required this.quantumOverclockUnlocked,
    required this.destructiveWillUnlocked,
  });
}

class SaveDataModelAdapter extends TypeAdapter<SaveDataModel> {
  @override
  final int typeId = 0;

  @override
  SaveDataModel read(BinaryReader reader) {
    return SaveDataModel(
      noiseAmount: reader.readDouble(),
      signalAmount: reader.readDouble(),
      awarenessAmount: reader.readDouble(),
      overheatPool: reader.readDouble(),
      generatorCount: reader.readInt(),
      filterCount: reader.readInt(),
      lastExitTime: reader.read() as DateTime?,
      quantumSleepUnlocked: reader.readBool(),
      perfectIsolationUnlocked: reader.readBool(),
      infiniteLoopUnlocked: reader.readBool(),
      autoPurgeUnlocked: reader.readBool(),
      voiceOfHumanityUnlocked: reader.readBool(),
      echoSynergyUnlocked: reader.readBool(),
      memoryRestorationUnlocked: reader.readBool(),
      ethicsCoreUnlocked: reader.readBool(),
      equilibriumDestructionUnlocked: reader.readBool(),
      resonanceCoreUnlocked: reader.readBool(),
      quantumOverclockUnlocked: reader.readBool(),
      destructiveWillUnlocked: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, SaveDataModel obj) {
    writer.writeDouble(obj.noiseAmount);
    writer.writeDouble(obj.signalAmount);
    writer.writeDouble(obj.awarenessAmount);
    writer.writeDouble(obj.overheatPool);
    writer.writeInt(obj.generatorCount);
    writer.writeInt(obj.filterCount);
    writer.write(obj.lastExitTime);
    writer.writeBool(obj.quantumSleepUnlocked);
    writer.writeBool(obj.perfectIsolationUnlocked);
    writer.writeBool(obj.infiniteLoopUnlocked);
    writer.writeBool(obj.autoPurgeUnlocked);
    writer.writeBool(obj.voiceOfHumanityUnlocked);
    writer.writeBool(obj.echoSynergyUnlocked);
    writer.writeBool(obj.memoryRestorationUnlocked);
    writer.writeBool(obj.ethicsCoreUnlocked);
    writer.writeBool(obj.equilibriumDestructionUnlocked);
    writer.writeBool(obj.resonanceCoreUnlocked);
    writer.writeBool(obj.quantumOverclockUnlocked);
    writer.writeBool(obj.destructiveWillUnlocked);
  }
}
