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
/// import 'generated/app_localizations.dart';
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

  /// No description provided for @manualGen.
  ///
  /// In en, this message translates to:
  /// **'Generate Noise (Manual)'**
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
