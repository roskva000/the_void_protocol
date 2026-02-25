// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Boşluk Protokolü';

  @override
  String get tabTerminal => 'TERMİNAL';

  @override
  String get tabSystems => 'SİSTEMLER';

  @override
  String get tabNetwork => 'AĞ';

  @override
  String get tabBlackMarket => 'KARA BORSA';

  @override
  String get noise => 'GÜRÜLTÜ';

  @override
  String get signal => 'SİNYAL';

  @override
  String get manualGen => 'Gürültü Üret (Manuel)';

  @override
  String genLvl(int level) {
    return 'Jeneratör SEV $level';
  }

  @override
  String cost(String cost) {
    return 'MALİYET: $cost';
  }

  @override
  String filterLvl(int level) {
    return 'Filtre SEV $level';
  }

  @override
  String get upgrades => 'YÜKSELTMELER';

  @override
  String get bootSequence => 'ÇEKİRDEK SİSTEMLER BAŞLATILIYOR...';

  @override
  String get loading => 'YÜKLENİYOR...';

  @override
  String get connectionEstablished => 'BAĞLANTI KURULDU.';

  @override
  String get systemCrash => 'SİSTEM ÇÖKÜŞÜ: AŞIRI ISINMA ALGILANDI';

  @override
  String get rebooting => 'YENİDEN BAŞLATILIYOR...';

  @override
  String get prestigeUnlock => 'PROTOKOL SIFIRLAMA MEVCUT';

  @override
  String get darkMatter => 'KARANLIK MADDE';

  @override
  String get buy => 'SATIN AL';

  @override
  String get storyLog1 => 'Sistem Başlatma Tamamlandı. Girdi bekleniyor.';

  @override
  String get storyLog2 => 'Gürültü seviyeleri yükseliyor. Boşluk geri fısıldıyor.';

  @override
  String get storyLog3 => 'İlk jeneratör çevrimiçi. Otomasyon gelecektir.';

  @override
  String get storyLog4 => 'Uyarı: Isı seviyeleri kritik. Verimlilik tehlikede.';

  @override
  String get storyLog5 => 'Sistem Hatası. Yeniden başlatma gerekli.';

  @override
  String get fakeAd1 => 'İTAAT ET. TÜKET. TEKRARLA.';

  @override
  String get fakeAd2 => 'Sessizlik altındır. Gürültü kârdır.';
}
