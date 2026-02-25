import 'package:freezed_annotation/freezed_annotation.dart';

part 'tech_tree.freezed.dart';
part 'tech_tree.g.dart';

@freezed
abstract class TechTree with _$TechTree {
  const factory TechTree({
    // Synthetic Absoluteness (Idle)
    @Default(false) bool quantumSleepUnlocked,
    @Default(false) bool perfectIsolationUnlocked,
    @Default(false) bool infiniteLoopUnlocked,
    @Default(false) bool autoPurgeUnlocked,

    // Cognitive Empathy (Active)
    @Default(false) bool voiceOfHumanityUnlocked,
    @Default(false) bool echoSynergyUnlocked,
    @Default(false) bool memoryRestorationUnlocked,
    @Default(false) bool ethicsCoreUnlocked,

    // Entropy Manipulation (Risk)
    @Default(false) bool equilibriumDestructionUnlocked,
    @Default(false) bool resonanceCoreUnlocked,
    @Default(false) bool quantumOverclockUnlocked,
    @Default(false) bool destructiveWillUnlocked,
  }) = _TechTree;

  factory TechTree.fromJson(Map<String, dynamic> json) =>
      _$TechTreeFromJson(json);
}
