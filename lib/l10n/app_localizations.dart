import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'The Void Protocol'**
  String get appTitle;

  /// No description provided for @tabTerminal.
  ///
  /// In en, this message translates to:
  /// **'TERMINAL'**
  String get tabTerminal;

  /// No description provided for @tabSystems.
  ///
  /// In en, this message translates to:
  /// **'SYSTEMS'**
  String get tabSystems;

  /// No description provided for @tabNetwork.
  ///
  /// In en, this message translates to:
  /// **'NETWORK'**
  String get tabNetwork;

  /// No description provided for @tabMatrix.
  ///
  /// In en, this message translates to:
  /// **'MATRIX'**
  String get tabMatrix;

  /// No description provided for @tabAnomalies.
  ///
  /// In en, this message translates to:
  /// **'ANOMALIES'**
  String get tabAnomalies;

  /// No description provided for @tabBlackMarket.
  ///
  /// In en, this message translates to:
  /// **'BLACK MARKET'**
  String get tabBlackMarket;

  /// No description provided for @noise.
  ///
  /// In en, this message translates to:
  /// **'NOISE'**
  String get noise;

  /// No description provided for @signal.
  ///
  /// In en, this message translates to:
  /// **'SIGNAL'**
  String get signal;

  /// No description provided for @stability.
  ///
  /// In en, this message translates to:
  /// **'STABILITY'**
  String get stability;

  /// No description provided for @heat.
  ///
  /// In en, this message translates to:
  /// **'HEAT'**
  String get heat;

  /// No description provided for @manualGen.
  ///
  /// In en, this message translates to:
  /// **'MANUAL GENERATE'**
  String get manualGen;

  /// No description provided for @genLvl.
  ///
  /// In en, this message translates to:
  /// **'Generator LVL {level}'**
  String genLvl(int level);

  /// No description provided for @cost.
  ///
  /// In en, this message translates to:
  /// **'COST: {cost}'**
  String cost(String cost);

  /// No description provided for @filterLvl.
  ///
  /// In en, this message translates to:
  /// **'Filter LVL {level}'**
  String filterLvl(int level);

  /// No description provided for @upgrades.
  ///
  /// In en, this message translates to:
  /// **'UPGRADES'**
  String get upgrades;

  /// No description provided for @bootSequence.
  ///
  /// In en, this message translates to:
  /// **'INITIALIZING CORE SYSTEMS...'**
  String get bootSequence;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'LOADING...'**
  String get loading;

  /// No description provided for @connectionEstablished.
  ///
  /// In en, this message translates to:
  /// **'CONNECTION ESTABLISHED.'**
  String get connectionEstablished;

  /// No description provided for @systemCrash.
  ///
  /// In en, this message translates to:
  /// **'SYSTEM CRASH: OVERHEAT DETECTED'**
  String get systemCrash;

  /// No description provided for @rebooting.
  ///
  /// In en, this message translates to:
  /// **'REBOOTING...'**
  String get rebooting;

  /// No description provided for @prestigeUnlock.
  ///
  /// In en, this message translates to:
  /// **'PROTOCOL RESET AVAILABLE'**
  String get prestigeUnlock;

  /// No description provided for @darkMatter.
  ///
  /// In en, this message translates to:
  /// **'DARK MATTER'**
  String get darkMatter;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'BUY'**
  String get buy;

  /// No description provided for @storyLog1.
  ///
  /// In en, this message translates to:
  /// **'System Initialization Complete. Awaiting input.'**
  String get storyLog1;

  /// No description provided for @storyLog2.
  ///
  /// In en, this message translates to:
  /// **'Noise levels rising. The Void whispers back.'**
  String get storyLog2;

  /// No description provided for @storyLog3.
  ///
  /// In en, this message translates to:
  /// **'First generator online. Automation is the future.'**
  String get storyLog3;

  /// No description provided for @storyLog4.
  ///
  /// In en, this message translates to:
  /// **'Warning: Heat levels critical. Efficiency compromise imminent.'**
  String get storyLog4;

  /// No description provided for @storyLog5.
  ///
  /// In en, this message translates to:
  /// **'System Failure. Reboot required.'**
  String get storyLog5;

  /// No description provided for @fakeAd1.
  ///
  /// In en, this message translates to:
  /// **'OBEY. CONSUME. REPEAT.'**
  String get fakeAd1;

  /// No description provided for @fakeAd2.
  ///
  /// In en, this message translates to:
  /// **'Silence is golden. Noise is profit.'**
  String get fakeAd2;

  /// No description provided for @coreAwareness.
  ///
  /// In en, this message translates to:
  /// **'CORE AWARENESS'**
  String get coreAwareness;

  /// No description provided for @transcendence.
  ///
  /// In en, this message translates to:
  /// **'TRANSCENDENCE'**
  String get transcendence;

  /// No description provided for @transcendenceDesc.
  ///
  /// In en, this message translates to:
  /// **'Accumulated Signal is sufficient for core initialization.\n\nRebooting will purge current memory but retain REMNANT DATA.\n\nProceed?'**
  String get transcendenceDesc;

  /// No description provided for @initialize.
  ///
  /// In en, this message translates to:
  /// **'INITIALIZE'**
  String get initialize;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get cancel;

  /// No description provided for @skillPurge.
  ///
  /// In en, this message translates to:
  /// **'System Purge'**
  String get skillPurge;

  /// No description provided for @skillStabilize.
  ///
  /// In en, this message translates to:
  /// **'Quantum Stabilization'**
  String get skillStabilize;

  /// No description provided for @skillOverclock.
  ///
  /// In en, this message translates to:
  /// **'Forced Overclock'**
  String get skillOverclock;

  /// No description provided for @skillPurgeDesc.
  ///
  /// In en, this message translates to:
  /// **'Clears 50% of Noise but destabilizes the core.'**
  String get skillPurgeDesc;

  /// No description provided for @skillStabilizeDesc.
  ///
  /// In en, this message translates to:
  /// **'Restores 25% Stability using Signal coherence.'**
  String get skillStabilizeDesc;

  /// No description provided for @skillOverclockDesc.
  ///
  /// In en, this message translates to:
  /// **'Boosts global speed by 200% for 15s. Generates massive Heat.'**
  String get skillOverclockDesc;

  /// No description provided for @anomalyDetected.
  ///
  /// In en, this message translates to:
  /// **'ANOMALY DETECTED'**
  String get anomalyDetected;

  /// No description provided for @breachProtocol.
  ///
  /// In en, this message translates to:
  /// **'BREACH PROTOCOL'**
  String get breachProtocol;

  /// No description provided for @systemFailure.
  ///
  /// In en, this message translates to:
  /// **'SYSTEM FAILURE'**
  String get systemFailure;

  /// No description provided for @blackMarketCorruptedCache.
  ///
  /// In en, this message translates to:
  /// **'Corrupted Data Cache'**
  String get blackMarketCorruptedCache;

  /// No description provided for @blackMarketCoolantLeak.
  ///
  /// In en, this message translates to:
  /// **'Coolant Leak'**
  String get blackMarketCoolantLeak;

  /// No description provided for @blackMarketRisk.
  ///
  /// In en, this message translates to:
  /// **'RISK LEVEL: HIGH'**
  String get blackMarketRisk;

  /// No description provided for @generators.
  ///
  /// In en, this message translates to:
  /// **'GENERATORS'**
  String get generators;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'FILTERS'**
  String get filters;

  /// No description provided for @nodeQuantumSleep.
  ///
  /// In en, this message translates to:
  /// **'QUANTUM SLEEP'**
  String get nodeQuantumSleep;

  /// No description provided for @nodePerfectIsolation.
  ///
  /// In en, this message translates to:
  /// **'PERFECT ISO.'**
  String get nodePerfectIsolation;

  /// No description provided for @nodeInfiniteLoop.
  ///
  /// In en, this message translates to:
  /// **'INF. LOOP'**
  String get nodeInfiniteLoop;

  /// No description provided for @nodeAutoPurge.
  ///
  /// In en, this message translates to:
  /// **'AUTO PURGE'**
  String get nodeAutoPurge;

  /// No description provided for @nodeVoiceHumanity.
  ///
  /// In en, this message translates to:
  /// **'VOICE OF HUM.'**
  String get nodeVoiceHumanity;

  /// No description provided for @nodeEchoSynergy.
  ///
  /// In en, this message translates to:
  /// **'ECHO SYN.'**
  String get nodeEchoSynergy;

  /// No description provided for @nodeMemoryRes.
  ///
  /// In en, this message translates to:
  /// **'MEMORY RES.'**
  String get nodeMemoryRes;

  /// No description provided for @nodeEthicsCore.
  ///
  /// In en, this message translates to:
  /// **'ETHICS CORE'**
  String get nodeEthicsCore;

  /// No description provided for @nodeEquiDest.
  ///
  /// In en, this message translates to:
  /// **'EQUI. DEST.'**
  String get nodeEquiDest;

  /// No description provided for @nodeResCore.
  ///
  /// In en, this message translates to:
  /// **'RES. CORE'**
  String get nodeResCore;

  /// No description provided for @nodeQuantOver.
  ///
  /// In en, this message translates to:
  /// **'Q. OVERCLOCK'**
  String get nodeQuantOver;

  /// No description provided for @nodeDestWill.
  ///
  /// In en, this message translates to:
  /// **'DEST. WILL'**
  String get nodeDestWill;

  /// No description provided for @anomalyDataCorruption.
  ///
  /// In en, this message translates to:
  /// **'Data Corruption'**
  String get anomalyDataCorruption;

  /// No description provided for @anomalyVoidLeak.
  ///
  /// In en, this message translates to:
  /// **'Void Leak'**
  String get anomalyVoidLeak;

  /// No description provided for @anomalyTemporalRift.
  ///
  /// In en, this message translates to:
  /// **'Temporal Rift'**
  String get anomalyTemporalRift;

  /// No description provided for @descDataCorruption.
  ///
  /// In en, this message translates to:
  /// **'Noise levels critical. Purge required.'**
  String get descDataCorruption;

  /// No description provided for @descVoidLeak.
  ///
  /// In en, this message translates to:
  /// **'Core stability failing. Seal the breach.'**
  String get descVoidLeak;

  /// No description provided for @descTemporalRift.
  ///
  /// In en, this message translates to:
  /// **'Time dilation detected. Synchronize immediately.'**
  String get descTemporalRift;

  /// No description provided for @pathAggressive.
  ///
  /// In en, this message translates to:
  /// **'AGGRESSIVE CORE'**
  String get pathAggressive;

  /// No description provided for @pathSilent.
  ///
  /// In en, this message translates to:
  /// **'SILENT CORE'**
  String get pathSilent;

  /// No description provided for @pathAggressiveDesc.
  ///
  /// In en, this message translates to:
  /// **'Start with +10% System Speed.'**
  String get pathAggressiveDesc;

  /// No description provided for @pathSilentDesc.
  ///
  /// In en, this message translates to:
  /// **'Reduce Noise generation by 10%.'**
  String get pathSilentDesc;

  /// No description provided for @dealVoidSiphon.
  ///
  /// In en, this message translates to:
  /// **'VOID SIPHON'**
  String get dealVoidSiphon;

  /// No description provided for @dealVoidSiphonDesc.
  ///
  /// In en, this message translates to:
  /// **'Sacrifice 20% Stability for instant Signal.'**
  String get dealVoidSiphonDesc;

  /// No description provided for @dealCorruptData.
  ///
  /// In en, this message translates to:
  /// **'CORRUPT DATA'**
  String get dealCorruptData;

  /// No description provided for @dealCorruptDataDesc.
  ///
  /// In en, this message translates to:
  /// **'Gain massive Signal. Warning: Immediate Anomaly.'**
  String get dealCorruptDataDesc;

  /// No description provided for @dealSuccess.
  ///
  /// In en, this message translates to:
  /// **'TRANSACTION COMPLETE'**
  String get dealSuccess;

  /// No description provided for @dealFail.
  ///
  /// In en, this message translates to:
  /// **'INSUFFICIENT RESOURCES'**
  String get dealFail;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get active;

  /// No description provided for @locked.
  ///
  /// In en, this message translates to:
  /// **'LOCKED'**
  String get locked;

  /// No description provided for @costSig.
  ///
  /// In en, this message translates to:
  /// **'{cost} SIG'**
  String costSig(Object cost);

  /// No description provided for @costStability.
  ///
  /// In en, this message translates to:
  /// **'{amount}% STABILITY'**
  String costStability(Object amount);

  /// No description provided for @rewardSignal.
  ///
  /// In en, this message translates to:
  /// **'{amount} SIGNAL'**
  String rewardSignal(Object amount);

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'UNKNOWN'**
  String get unknown;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'tr': return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
