// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'The Void Protocol';

  @override
  String get tabTerminal => 'TERMINAL';

  @override
  String get tabSystems => 'SYSTEMS';

  @override
  String get tabNetwork => 'NETWORK';

  @override
  String get tabMatrix => 'MATRIX';

  @override
  String get tabAnomalies => 'ANOMALIES';

  @override
  String get tabBlackMarket => 'BLACK MARKET';

  @override
  String get noise => 'NOISE';

  @override
  String get signal => 'SIGNAL';

  @override
  String get stability => 'STABILITY';

  @override
  String get heat => 'HEAT';

  @override
  String get manualGen => 'MANUAL GENERATE';

  @override
  String genLvl(int level) {
    return 'Generator LVL $level';
  }

  @override
  String cost(String cost) {
    return 'COST: $cost';
  }

  @override
  String filterLvl(int level) {
    return 'Filter LVL $level';
  }

  @override
  String get upgrades => 'UPGRADES';

  @override
  String get bootSequence => 'INITIALIZING CORE SYSTEMS...';

  @override
  String get loading => 'LOADING...';

  @override
  String get connectionEstablished => 'CONNECTION ESTABLISHED.';

  @override
  String get systemCrash => 'SYSTEM CRASH: OVERHEAT DETECTED';

  @override
  String get rebooting => 'REBOOTING...';

  @override
  String get prestigeUnlock => 'PROTOCOL RESET AVAILABLE';

  @override
  String get darkMatter => 'DARK MATTER';

  @override
  String get buy => 'BUY';

  @override
  String get storyLog1 => 'System Initialization Complete. Awaiting input.';

  @override
  String get storyLog2 => 'Noise levels rising. The Void whispers back.';

  @override
  String get storyLog3 => 'First generator online. Automation is the future.';

  @override
  String get storyLog4 => 'Warning: Heat levels critical. Efficiency compromise imminent.';

  @override
  String get storyLog5 => 'System Failure. Reboot required.';

  @override
  String get fakeAd1 => 'OBEY. CONSUME. REPEAT.';

  @override
  String get fakeAd2 => 'Silence is golden. Noise is profit.';

  @override
  String get coreAwareness => 'CORE AWARENESS';

  @override
  String get transcendence => 'TRANSCENDENCE';

  @override
  String get transcendenceDesc => 'Accumulated Signal is sufficient for core initialization.\n\nRebooting will purge current memory but retain REMNANT DATA.\n\nProceed?';

  @override
  String get initialize => 'INITIALIZE';

  @override
  String get cancel => 'CANCEL';

  @override
  String get skillPurge => 'System Purge';

  @override
  String get skillStabilize => 'Quantum Stabilization';

  @override
  String get skillOverclock => 'Forced Overclock';

  @override
  String get skillPurgeDesc => 'Clears 50% of Noise but destabilizes the core.';

  @override
  String get skillStabilizeDesc => 'Restores 25% Stability using Signal coherence.';

  @override
  String get skillOverclockDesc => 'Boosts global speed by 200% for 15s. Generates massive Heat.';

  @override
  String get anomalyDetected => 'ANOMALY DETECTED';

  @override
  String get breachProtocol => 'BREACH PROTOCOL';

  @override
  String get systemFailure => 'SYSTEM FAILURE';

  @override
  String get blackMarketCorruptedCache => 'Corrupted Data Cache';

  @override
  String get blackMarketCoolantLeak => 'Coolant Leak';

  @override
  String get blackMarketRisk => 'RISK LEVEL: HIGH';

  @override
  String get generators => 'GENERATORS';

  @override
  String get filters => 'FILTERS';

  @override
  String get nodeQuantumSleep => 'QUANTUM SLEEP';

  @override
  String get nodePerfectIsolation => 'PERFECT ISO.';

  @override
  String get nodeInfiniteLoop => 'INF. LOOP';

  @override
  String get nodeAutoPurge => 'AUTO PURGE';

  @override
  String get nodeVoiceHumanity => 'VOICE OF HUM.';

  @override
  String get nodeEchoSynergy => 'ECHO SYN.';

  @override
  String get nodeMemoryRes => 'MEMORY RES.';

  @override
  String get nodeEthicsCore => 'ETHICS CORE';

  @override
  String get nodeEquiDest => 'EQUI. DEST.';

  @override
  String get nodeResCore => 'RES. CORE';

  @override
  String get nodeQuantOver => 'Q. OVERCLOCK';

  @override
  String get nodeDestWill => 'DEST. WILL';

  @override
  String get anomalyDataCorruption => 'Data Corruption';

  @override
  String get anomalyVoidLeak => 'Void Leak';

  @override
  String get anomalyTemporalRift => 'Temporal Rift';

  @override
  String get descDataCorruption => 'Noise levels critical. Purge required.';

  @override
  String get descVoidLeak => 'Core stability failing. Seal the breach.';

  @override
  String get descTemporalRift => 'Time dilation detected. Synchronize immediately.';

  @override
  String get pathAggressive => 'AGGRESSIVE CORE';

  @override
  String get pathSilent => 'SILENT CORE';

  @override
  String get pathAggressiveDesc => 'Start with +10% System Speed.';

  @override
  String get pathSilentDesc => 'Reduce Noise generation by 10%.';

  @override
  String get dealVoidSiphon => 'VOID SIPHON';

  @override
  String get dealVoidSiphonDesc => 'Sacrifice 20% Stability for instant Signal.';

  @override
  String get dealCorruptData => 'CORRUPT DATA';

  @override
  String get dealCorruptDataDesc => 'Gain massive Signal. Warning: Immediate Anomaly.';

  @override
  String get dealSuccess => 'TRANSACTION COMPLETE';

  @override
  String get dealFail => 'INSUFFICIENT RESOURCES';

  @override
  String get active => 'ACTIVE';

  @override
  String get locked => 'LOCKED';

  @override
  String costSig(Object cost) {
    return '$cost SIG';
  }

  @override
  String costStability(Object amount) {
    return '$amount% STABILITY';
  }

  @override
  String rewardSignal(Object amount) {
    return '$amount SIGNAL';
  }

  @override
  String get unknown => 'UNKNOWN';
}
