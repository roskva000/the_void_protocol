# MODÜL 6: IMPLEMENTATION_ROADMAP.md
## THE VOID PROTOCOL - AŞAMALI UYGULAMA PLANI VE KLASÖR YAPISI

Bu doküman, otonom kodlama ajanının (AI Agent) projeyi sıfırdan inşa ederken izleyeceği **değiştirilemez** yol haritasıdır. Ajan, bir aşamadaki testleri ve gereksinimleri tamamen bitirmeden (başarılı bir şekilde derlenmeden) KESİNLİKLE bir sonraki aşamaya geçemez. 

### 1. KLASÖR MİMARİSİ (ZORUNLU YAPI)
Proje kök dizinindeki `lib/` klasörü aşağıdaki gibi yapılandırılacaktır. Ajan, dosyaları bu yapıya sadık kalarak oluşturacaktır:

    lib/
     ┣ core/
     ┃ ┣ constants/ (app_colors.dart, app_typography.dart)
     ┃ ┣ utils/ (haptic_utils.dart, math_utils.dart)
     ┃ ┗ theme/ (glassmorphism_styles.dart)
     ┣ domain/
     ┃ ┣ entities/ (noise_entity.dart, signal_entity.dart vb. - FREEZED)
     ┃ ┗ usecases/ (pipeline_calculator.dart, cost_calculator.dart)
     ┣ data/
     ┃ ┣ models/ (Hive/JSON serileştirme modelleri)
     ┃ ┗ repositories/ (offline_progress_repo.dart)
     ┣ presentation/
     ┃ ┣ providers/ (pipeline_provider.dart, engine_provider.dart vb. - RIVERPOD)
     ┃ ┣ screens/ (void_screen.dart)
     ┃ ┗ widgets/ (glass_panel.dart, story_log_widget.dart, resource_bar.dart)
     ┗ main.dart

### 2. FAZ 1: DOMAIN KATMANI VE MATEMATİK (Görsel Yok)
**Öncelik:** Saf iş mantığının ve varlıkların (entities) oluşturulması. Flutter UI paketleri bu fazda kullanılamaz.
1. `freezed_annotation` ve `json_serializable` paketlerini ekle.
2. `domain/entities/` altında Gürültü, Filtre, Sinyal, Farkındalık, Overheat ve TechTree yapılarını değişmez (immutable) olarak tanımla. Kodu `build_runner` ile üret.
3. `domain/usecases/` altında `CostCalculator` (geometrik dizi tabanlı bulk-buy hesaplayıcısı) ve `PipelineCalculator` (Darboğaz, Tüketim ve Overheat hesaplayıcısı) sınıflarını statik saf fonksiyonlar (pure functions) olarak yaz.
4. **Faz 1 Testi:** Matematiksel algoritmaların O(1) karmaşıklığında doğru çalıştığını doğrulayan birim testleri (Unit Tests) yaz.

### 3. FAZ 2: DATA KATMANI VE ÇEVRİMDIŞI SİMÜLASYON (Offline Progress)
**Öncelik:** Veri kalıcılığının ve uygulamanın kapalı kaldığı sürenin hesaplanması.
1. `Hive` veya `Isar` veritabanını kur.
2. `AppLifecycleState` dinleyicisi oluşturarak uygulama arka plana atıldığında `DateTime.now()` damgasını kaydet.
3. Uygulama açıldığında geçen süreyi (Delta Seconds) hesaplayıp, `PipelineCalculator` üzerinden tek bir kütlesel işlemle (integral) offline kazancı hesaplayan Repo'yu yaz.

### 4. FAZ 3: STATE MANAGEMENT (RIVERPOD MICRO-STORES)
**Öncelik:** Modül 1'de belirtilen 5 mikro-deponun oluşturulması.
1. `riverpod_generator` paketini ekle.
2. `engine_provider`, `pipeline_provider`, `upgrades_provider`, `meta_provider` ve `story_provider` dosyalarını `presentation/providers/` altında oluştur.
3. Provider'ların birbirleriyle haberleşmesi için (örneğin engine'in pipeline'ı tetiklemesi) `ref.read()` bağlantılarını kur.
4. **Faz 3 Testi:** Provider state'lerinin `.copyWith` ile güncellendiğinde doğru değerleri yaydığını (emit) test et.

### 5. FAZ 4: İZOLE MOTOR (60 TPS ENGINE)
**Öncelik:** Oyun döngüsünün UI thread'den ayrılması.
1. `engine_provider.dart` içinde bir `TickerProvider` (veya Isolate) oluştur.
2. Saniyede 60 kez tetiklenecek `tick(Duration elapsed)` fonksiyonunu yaz.
3. Her tick'te `dt` (delta time) hesapla, `pipeline_provider` metodlarına `dt` değerini göndererek saniyelik üretimi milisaniyelere böl.

### 6. FAZ 5: APTAL ARAYÜZ (DUMB UI) VE GLASSMORPHISM
**Öncelik:** Sıfır mantık, sadece state'i dinleyen görsel bileşenlerin inşası.
1. `Space Mono` ve `Inter` fontlarını projeye dahil et.
2. Kömür grisi, neon mavi ve bronz HEX kodlarını `AppColors` sınıfına ekle.
3. `RepaintBoundary` ile sarılmış, `BackdropFilter` kullanan `GlassPanel` bileşenini yaz.
4. UI içindeki barların dolum oranlarını `ref.watch(pipelineProvider.select((s) => s.fillRatio))` şeklinde NOKTA ATIŞI seçicilerle bağla.
5. Hiçbir butonun `onPressed` metodunda matematik veya if/else (bakiye kontrolü) yazma. Sadece `ref.read(upgradesProvider.notifier).buyFilter()` çağrısı yap.

### 7. FAZ 6: HAPTICS, HİKAYE VE CİLALAMA (POLISH)
**Öncelik:** Modül 3 ve Modül 4'teki hissiyatın ve hikayenin oyuna entegre edilmesi.
1. Satın almalara, sekme geçişlerine ve menülere Modül 3'teki kesin `HapticFeedback` karşılıklarını bağla.
2. `story_provider`'ı dinleyen bir `StoryLogWidget` oluştur. Bu widget ekranın üstünde sabit duracak ve state'te yeni bir metin belirdiğinde Typewriter (daktilo) efektiyle yazıp, 5 saniye sonra Fade-out olacaktır.
3. Aşırı ısınma (Overheat) durumunda arayüzün titremesini (Shake animation) ve ekranın kenarlarında `Rusted Bronze` renginde bir Vignette/Glow belirmesini sağla.
4. Ulu Çöküş (Prestige) butonuna basıldığında ekranı flaşlatıp, tüm provider'ları başlangıç state'ine resetleyen `resetAll()` metodunu yaz.

### KESİN UYARI (AI AJANI İÇİN)
Bu adımlar sırayla yapılacaktır. Eğer terminalde bir hata alırsan, hatayı geçiştirmek için mimariyi bozma. "God Class" yaratmak, değişkenleri global yapmak veya hesaplamaları Widget `build` metodunun içine taşımak KESİNLİKLE YASAKTIR. Clean Architecture kuralları her şeyden üstündür.