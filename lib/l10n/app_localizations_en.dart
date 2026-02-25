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
  String get tabBlackMarket => 'BLACK MARKET';

  @override
  String get noise => 'NOISE';

  @override
  String get signal => 'SIGNAL';

  @override
  String get manualGen => 'Generate Noise (Manual)';

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
}
