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
  String get tabMatrix => 'MATRİS';

  @override
  String get tabAnomalies => 'ANOMALİLER';

  @override
  String get tabBlackMarket => 'KARA BORSA';

  @override
  String get noise => 'GÜRÜLTÜ';

  @override
  String get signal => 'SİNYAL';

  @override
  String get stability => 'KARARLILIK';

  @override
  String get heat => 'ISI';

  @override
  String get manualGen => 'MANUEL ÜRETİM';

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

  @override
  String get coreAwareness => 'ÇEKİRDEK BİLİNCİ';

  @override
  String get transcendence => 'AŞKINLIK';

  @override
  String get transcendenceDesc => 'Biriken Sinyal çekirdek başlatması için yeterli.\n\nYeniden başlatma mevcut hafızayı temizleyecek ancak KALINTI VERİSİNİ koruyacaktır.\n\nDevam edilsin mi?';

  @override
  String get initialize => 'BAŞLAT';

  @override
  String get cancel => 'İPTAL';

  @override
  String get skillPurge => 'Sistem Temizliği';

  @override
  String get skillStabilize => 'Kuantum Stabilizasyon';

  @override
  String get skillOverclock => 'Zorunlu Hız Aşırtma';

  @override
  String get skillPurgeDesc => 'Gürültünün %50\'sini temizler ancak çekirdeği kararsızlaştırır.';

  @override
  String get skillStabilizeDesc => 'Sinyal tutarlılığını kullanarak Kararlılığı %25 geri yükler.';

  @override
  String get skillOverclockDesc => 'Küresel hızı 15sn boyunca %200 artırır. Devasa Isı üretir.';

  @override
  String get anomalyDetected => 'ANOMALİ TESPİT EDİLDİ';

  @override
  String get breachProtocol => 'İHLAL PROTOKOLÜ';

  @override
  String get systemFailure => 'SİSTEM HATASI';

  @override
  String get blackMarketCorruptedCache => 'Bozuk Veri Önbelleği';

  @override
  String get blackMarketCoolantLeak => 'Soğutucu Sızıntısı';

  @override
  String get blackMarketRisk => 'RİSK SEVİYESİ: YÜKSEK';

  @override
  String get generators => 'JENERATÖRLER';

  @override
  String get filters => 'FİLTRELER';

  @override
  String get nodeQuantumSleep => 'KUANTUM UYKU';

  @override
  String get nodePerfectIsolation => 'MÜKEMMEL İZO.';

  @override
  String get nodeInfiniteLoop => 'SONSUZ DÖNGÜ';

  @override
  String get nodeAutoPurge => 'OTO TEMİZLİK';

  @override
  String get nodeVoiceHumanity => 'İNSAN SESİ';

  @override
  String get nodeEchoSynergy => 'EKO SİNERJİ';

  @override
  String get nodeMemoryRes => 'HAFIZA RES.';

  @override
  String get nodeEthicsCore => 'ETİK ÇEKİRDEK';

  @override
  String get nodeEquiDest => 'DENGE YIKIMI';

  @override
  String get nodeResCore => 'REZ. ÇEKİRDEK';

  @override
  String get nodeQuantOver => 'K. HIZ AŞIRTMA';

  @override
  String get nodeDestWill => 'YIKICI İRADE';

  @override
  String get anomalyDataCorruption => 'Veri Bozulması';

  @override
  String get anomalyVoidLeak => 'Boşluk Sızıntısı';

  @override
  String get anomalyTemporalRift => 'Zamansal Yarık';

  @override
  String get descDataCorruption => 'Gürültü seviyeleri kritik. Temizlik gerekli.';

  @override
  String get descVoidLeak => 'Çekirdek kararlılığı düşüyor. Sızıntıyı kapat.';

  @override
  String get descTemporalRift => 'Zaman genişlemesi algılandı. Derhal senkronize et.';

  @override
  String get pathAggressive => 'AGRESİF ÇEKİRDEK';

  @override
  String get pathSilent => 'SESSİZ ÇEKİRDEK';

  @override
  String get pathAggressiveDesc => '+%10 Sistem Hızı ile başla.';

  @override
  String get pathSilentDesc => 'Gürültü üretimini %10 azalt.';

  @override
  String get dealVoidSiphon => 'BOŞLUK SİFONU';

  @override
  String get dealVoidSiphonDesc => '%20 Kararlılık feda et, anında Sinyal kazan.';

  @override
  String get dealCorruptData => 'BOZUK VERİ';

  @override
  String get dealCorruptDataDesc => 'Devasa Sinyal kazan. Uyarı: Anında Anomali.';

  @override
  String get dealSuccess => 'İŞLEM TAMAMLANDI';

  @override
  String get dealFail => 'YETERSİZ KAYNAK';
}
