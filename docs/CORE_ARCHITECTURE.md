# MODÜL 1: CORE_ARCHITECTURE.md
## THE VOID PROTOCOL - TEMEL MİMARİ VE SİSTEM KURALLARI

Bu doküman, "The Void Protocol" projesinin temel omurgasını tanımlar. [cite_start]Otonom yapay zeka kodlama ajanı, bu belgede yer alan mimari kuralları yorumlamayacak, harfiyen ve istisnasız bir şekilde koda dökecektir[cite: 183]. [cite_start]Geçmişte yaşanan "God Class" ve "Spagetti Kod" anti-desenlerine karşı sıfır tolerans politikası uygulanacaktır[cite: 4, 196].

### 1. KUSURSUZ TEMİZ MİMARİ (CLEAN ARCHITECTURE) HİYERARŞİSİ
[cite_start]Proje, özellik odaklı (feature-first) modüler bir yaklaşımla üç ana soyutlama katmanına bölünecektir[cite: 198]. [cite_start]Bağımlılıklar sadece dıştan içe (UI -> Domain) doğru akabilir[cite: 18].

#### 1.1. Domain Katmanı (Çekirdek)
* Uygulamanın kalbidir. [cite_start]Kesinlikle saf Dart dili ile yazılmalıdır[cite: 19, 200]. 
* [cite_start]Flutter framework'üne, UI bileşenlerine veya veri tabanı paketlerine bağımlı olamaz[cite: 201].
* [cite_start]Tüm veri yapıları (Entities), `freezed` paketi kullanılarak mutlak surette değiştirilemez (immutable) olarak kodlanacaktır[cite: 21].
* [cite_start]Durum güncellemeleri, varlıkların yeni kopyasını üreten `.copyWith()` metotlarıyla yapılmalıdır[cite: 22].
* [cite_start]Matematiksel ekonomi formülleri ve boru hattı algoritmaları bu katmanda birer kullanım senaryosu (UseCase) olarak tasarlanacaktır[cite: 20, 203].

#### 1.2. Data Katmanı (Veri Kalıcılığı)
* [cite_start]Domain katmanında tanımlanan soyut arayüzlerin (Abstract Repositories) somut uygulamalarını (Repository Implementations) içerir[cite: 202, 204].
* [cite_start]Çevrimdışı ilerleme (offline progress) bu proje için hayatidir[cite: 205]. [cite_start]Oyuncu uygulamayı kapattığında son aktif zaman damgası (timestamp) bu katman aracılığıyla asenkron olarak kaydedilir[cite: 24, 331].
* [cite_start]Verilerin yerel depolanması için `Hive` (veya eşdeğeri NoSQL çözümleri) entegre edilecek, JSON serileştirme işlemleri burada yapılacaktır[cite: 205].

#### 1.3. Presentation Katmanı (Kullanıcı Arayüzü)
* [cite_start]Sadece görsel bileşenleri ve Riverpod Notifier sınıflarını barındırır[cite: 207, 208].
* [cite_start]Riverpod sağlayıcılarını dinleyerek arayüzü günceller ve kullanıcı dokunuşlarını Domain katmanındaki UseCase'lere iletir[cite: 27, 209].

### 2. KESİN "APTAL ARAYÜZ" (DUMB UI) YASASI
[cite_start]"Dumb UI" bir tavsiye değil, ihlal edilemez bir yasadır[cite: 218].
* [cite_start]**Yasaklar:** Arayüz (Widget) sınıflarının içinde if-else bloklarıyla kaynak kapasite kontrolü (`if (noise > cost)`), maliyet hesaplaması veya mantık yürütmek kesinlikle yasaktır[cite: 29, 30, 219].
* **Görev:** Kullanıcı butona bastığında, arayüz sadece sağlayıcıdaki metodu tetiklemelidir. [cite_start]İşlemin başarılı olup olmadığını hesaplamamalıdır[cite: 33].
* [cite_start]**Dinamik Durumlar:** Bir butonun aktif/pasif olma durumu veya rengi, arayüzde hesaplanamaz; doğrudan Provider'dan gelen bir boolean değere bağlanmalıdır[cite: 34, 35].
* **Seçici Dinleme (Select):** Gereksiz yeniden çizmeleri (rebuilds) önlemek için `ref.watch(pipelineProvider)` KULLANILAMAZ. [cite_start]Bunun yerine nokta atışı dinleme yapan `ref.watch(pipelineProvider.select((state) => state.signalCount))` formatı zorunludur[cite: 32, 223].

### 3. RIVERPOD MICRO-STORES (MİKRO-DEPOLAR) YAPISI
[cite_start]Durum yönetimi tek bir devasa sınıfta toplanamaz[cite: 37, 210]. [cite_start]Modern Flutter standartlarına uygun olarak `riverpod_generator` ile oluşturulacak `Notifier` ve `AsyncNotifier` yapıları kullanılacaktır[cite: 39, 211]. Sistem 5 mikro-depoya bölünecektir:

1.  [cite_start]**`engine_provider`:** 60 TPS motor döngüsünü yönetir, zaman farkını (Delta Time - dt) hesaplar ve tüm sisteme saat vurumu (tick) sinyali gönderir[cite: 40, 41].
2.  **`pipeline_provider`:** Gürültü, Filtre, Sinyal ve Farkındalık miktarlarını, saniyelik üretim oranlarını ve kapasite durumlarını yönetir. [cite_start]En yüksek frekanslı sağlayıcıdır[cite: 42, 212, 213, 214].
3.  [cite_start]**`upgrades_provider`:** Satın alınabilir yükseltmelerin seviyelerini, logaritmik/üstel maliyet hesaplamalarını ve uygulanacak global çarpanları (multipliers) tutar[cite: 43, 215].
4.  [cite_start]**`meta_provider`:** Momentum mekaniğini, Overheat (Aşırı Isınma) toleransını, çevrimdışı ilerleme (offline progress) özetini ve Ulu Çöküş (Prestige) puanlarını koordine eder[cite: 44, 216].
5.  [cite_start]**`story_provider`:** Sayısal eşiklere göre hikaye kilitlerini açar, felsefi diyalogları ve UI animasyon fazlarının tetikleyicilerini yönetir[cite: 45, 217].

### 4. İZOLE EDİLMİŞ MOTOR DÖNGÜSÜ (ISOLATE GAME LOOP)
[cite_start]Saniyede onlarca kez çalışan matematiksel hesaplamalar ana UI iş parçacığında (Main Thread) yapılamaz; aksi takdirde kare atlamaları (frame drops) ve takılmalar (jank) yaşanır[cite: 47, 225].

* [cite_start]**Zamanlayıcı Yasakları:** Ana thread üzerinde `Timer.periodic(16ms)` kullanılarak oluşturulan asenkron döngüler KESİNLİKLE YASAKTIR[cite: 225].
* [cite_start]**Isolate/Ticker Kullanımı:** Motor, Dart'ın `Isolate` (veya `compute`) fonksiyonları kullanılarak bağımsız bir arka plan iş parçacığına devredilmeli veya ekran yenileme frekansıyla uyumlu bir `TickerProvider` sınıfıyla 60 TPS (Tick per Second) olarak çalıştırılmalıdır[cite: 48, 224, 226].
* [cite_start]**Delta Time (dt):** Her 16 milisaniyede bir tetiklenen döngü, mevcut tam zaman ile bir önceki zaman arasındaki farkı (dt) hesaplayarak saniyelik tüm üretim ve tüketim formüllerini bu `dt` değeri ile çarpmalıdır[cite: 52, 53].
* [cite_start]**İletişim (Port Messaging):** İzole edilmiş motor ile ana UI thread arasındaki iletişim `SendPort` ve `ReceivePort` üzerinden sağlanacaktır[cite: 54].
* [cite_start]**FrameData:** İzole motor, saniyede 60 kez ana iş parçacığına `FrameData` (kaynaklar, hızlar ve overheat oranlarını içeren serileştirilebilir veri paketi) gönderecek; ana thread bunu dinleyerek arayüzü güncelleyecektir[cite: 55, 56, 57].
* [cite_start]**Performans:** Sıklıkla güncellenen sayısal metinlerin (60 TPS akan sayılar) etrafı, arkaplanın gereksiz yere çizilmesini engellemek için `RepaintBoundary` ile sarılmalıdır[cite: 58].