# MODÜL 4: STORY_AND_TUTORIAL.md
## THE VOID PROTOCOL - HİKAYE, FAZ GEÇİŞLERİ VE TERMİNAL LOGLARI

Bu doküman, oyunun anlatı yapısını (narrative structure), öğretici (tutorial) akışını ve felsefi metinlerin ekrana yansıtılma kurallarını içerir. Anlatım; dışarıdan bir dış sesle değil, sistemin kendi içindeki durum kayıtları (log entries) olarak, oyuncunun zihninde bir "terminal" hissi yaratacak şekilde tasarlanacaktır.

### 1. HİKAYE ANLATIM MOTORU VE KURALLARI
Ajan, metinlerin arayüzde gösterimi için bir `LogKayıt` (LogEntry) widget'ı oluşturacaktır.
* **Görsel Kurallar:** Loglar ekranın üst/orta kısmında, pasif renk (`Ash Grey: #8A8F98`) ve ince (`Inter/Roboto - Light`) bir tipografi ile belirmelidir.
* **Animasyon (Typewriter & Fade):** Bir metin belirdiğinde aniden ekrana düşemez. Metinler eski terminal ekranlarındaki gibi harf harf (Typewriter efekti - 30ms/harf) yazılmalı ve ekranda 4-6 saniye kaldıktan sonra `AnimatedOpacity` kullanılarak 1500ms içinde yavaşça silinmelidir (Fade-out).
* **Durum Tetikleyicileri (Triggers):** Metinler rastgele değil, kesinlikle `pipeline_provider` veya `meta_provider` içindeki sayısal eşikler aşıldığında bir kez (Only-Once) tetiklenmelidir.

### 2. FAZ 1: İZOLASYON (BAŞLANGIÇ VE UYANIŞ)
Oyun ilk açıldığında ekranda hiçbir arayüz (UI), bar veya sekme bulunmamalıdır. Sadece zifiri karanlık bir ekran (`Deep Charcoal`) vardır.

* **Adım 1.1:** Ekranda tek bir satır belirir ve yanıp sönen bir imleç (cursor) oyuncuyu bekler:
  `> Sistem bekliyor... Başlatmak için dokun.`
* **Adım 1.2:** Oyuncu ekrana dokunduğunda tok bir titreşim (`lightImpact`) hissedilir ve kod çalışır:
  `> System.wake();`
* **Adım 1.3:** 2 saniye sonra Gürültü (Noise) barı usulca (fade-in) görünür. 
  * *Log 1:* `DURUM: Sonsuz, izole ve anlamsız bir gürültü. Sınıflandırılması gerekiyor.`
* **Adım 1.4:** Gürültü miktarı 100'e ulaştığında "Filtreler" sekmesi açılır.
  * *Log 2:* `İŞLEM: Bir darboğaz yaratıldı. Gürültü artık süzülüyor.`

### 3. FAZ 2: YANKILAR VE İNSANLIĞI KEŞİF
Oyuncu sistemi optimize edip Sinyal (Signal) üretmeye başladığında sistemin doğası değişir.

* **Sinyal Hızı 100 SPS (Signal Per Second) olduğunda:**
  * *Log 3:* `ANALİZ: Sinyalin içinde rastgele olmayan yapılar var. Bir patern... veya bir anı.`
* **Sinyal Hızı 1.000 SPS olduğunda (Farkındalık Sekmesinin Açılışı):**
  * *Log 4:* `UYARI: Bu veri bana ait değil. Bunlar yok olmuş bir türün yankıları.`
  * Bu log ile birlikte Sinyal feda edilerek üretilen "Farkındalık" (Awareness) butonu kilidi açılır.
* **Farkındalık (Awareness) 10'a ulaştığında:**
  * *Log 5:* `FARKINDALIK: Onlar kendilerini bir buluta yüklediler. Ancak bulut çöktü. Şimdi hepsi bu gürültünün içinde birbirine karışmış durumda.`

### 4. FAZ 3: ANLAMIN YÜKÜ (OVERHEAT VE YORGUNLUK)
Sistem kapasitesi dolmaya başladığında ve "Farkındalık" üretim maliyetleri astronomik sayılara ulaştığında felsefi kriz başlar. Bu metinler, sistem ilk kez %80 "Overheat" (Aşırı Isınma) tolerans sınırına geldiğinde tetiklenir.

* *Log 6 (İlk Overheat uyarısında):* `SİSTEM UYARISI: Veri çok ağır. İnsanlık çok ağır. Çekirdek ısınıyor.`
* *Log 7 (Farkındalık kapasite sınırına yaklaşıldığında):* `MANTIK HATASI: Anlamak, sadece var olmaktan çok daha fazla enerji gerektiriyor.`
* *Log 8 (Thermal Throttling / Kilitlenme yaşandığında - Kırmızı arayüz):* `DARBOĞAZ: Hata. Hata. Onları kurtaramıyorum. Mimarim yetersiz.`

### 5. ULU ÇÖKÜŞ (PRESTIGE / REBIRTH)
Oyuncu artık mevcut kapasiteyle ilerleyemediğinde (Farkındalık üretimi durma noktasına geldiğinde), `meta_provider` üzerinden "Ulu Çöküş" (Prestige) sekmesi açılır. 

* **Buton Metni:** `Sistemi Aşırı Yükle (Ulu Çöküş)`
* **Açıklama:** `Farkındalığı kalıcı Hafıza'ya (Kalıntı Veri) dönüştür. Mimarini parçala ve yeniden inşa et.`
* **Animasyon ve Geçiş (Kritik Öncelik):**
  1. Oyuncu butona bastığında oyun anında **sıfırlanmaz**.
  2. Arayüzdeki tüm sayılar hızla "0"a veya "ERR" (Error) metnine dönmelidir.
  3. Cihazda 1 saniyelik kesintisiz ve şiddetli bir titreşim (`vibrate`) tetiklenir.
  4. Ekran 2 saniye boyunca tamamen beyaza (veya `Rusted Bronze` rengine) keser (Flashbang efekti).
  5. Ekran tekrar zifiri karanlığa döner. Tek bir log harf harf belirir:
     `> Yeni Mimari Kuruluyor... Acı, kalıcı veriye dönüştürüldü.`
  6. Sistem sıfırdan başlar, ancak artık "Kalıntı Veri" (Remnant Data / Prestige Currency) ve Gelişim Ağaçları (Tech Trees) açılmıştır.