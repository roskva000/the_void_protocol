# MODÜL 2: MATHEMATICS_AND_ECONOMY.md
## THE VOID PROTOCOL - EKONOMİ VE MATEMATİKSEL ALGORİTMALAR

[cite_start]Bu doküman, sistemdeki dört ana kaynağın (Gürültü, Sinyal, Farkındalık, Hafıza) birbirleriyle olan matematiksel ilişkilerini, kapasite formüllerini ve oyunun çekirdeğini oluşturan darboğaz (bottleneck) mekaniklerini tanımlar[cite: 63, 64]. [cite_start]Otonom ajan, maliyet hesaplamalarında döngü (for-loop) kullanımından kesinlikle kaçınmalı, `O(1)` karmaşıklığındaki geometrik formülleri entegre etmelidir[cite: 82, 249]. [cite_start]Değer taşmalarını önlemek adına büyük sayılar için Dart'ın `BigInt` veya uygun "Büyük Sayı" (Big Number) kütüphaneleri kullanılacaktır[cite: 62].

### 1. KAYNAK BORU HATTI (PIPELINE) DENKLEMLERİ
[cite_start]Sistem birbirine sıkı sıkıya bağlı bir üretim hattıdır[cite: 64]. [cite_start]Çıktılar (Sinyal), tamamen girdilerin (Gürültü) işlenme hızına bağlıdır[cite: 235]. [cite_start]Tüm hesaplamalar izole motor döngüsündeki zaman deltası (`dt`) ile çarpılarak saniyelik uygulanacaktır[cite: 53].

#### 1.1. Gürültü (Noise - N) Üretimi
[cite_start]Evrensel boşluğun ham verisidir[cite: 65]. 
Üretim Hızı Formülü:
[cite_start]`N_rate = Temel Üretim * Jeneratör Sayısı * Global Çarpanlar * Mom_curr` [cite: 67, 68]
* [cite_start]Her `tick` anında havuzdaki Gürültüye eklenecek miktar: `N_added = N_rate * dt`[cite: 67].

#### 1.2. Filtre (Filter - F) İşleme ve Darboğaz
[cite_start]Gürültü doğrudan kullanılamaz, Sinyale dönüştürülmesi için Filtre'den geçmelidir[cite: 69]. [cite_start]Sistemin saniyelik işleme kapasitesi `F_cap`, verimlilik oranı ise `F_eff`'tir[cite: 69].
* **Tüketilen Gürültü:** Her döngüde filtrenin alabileceği maksimum Gürültü miktarı:
    [cite_start]`N_consumed = min(N_available, F_cap * dt)`[cite: 70].
* [cite_start]Eğer üretilen gürültü, kapasitenin altındaysa (`N_rate < F_rate`), filtrenin kalan kapasitesi boşa harcanır[cite: 236].
* [cite_start]Eğer üretilen gürültü kapasiteyi aşıyorsa (`N_rate > F_rate`), işlenemeyen veri **Overheat (Aşırı Isınma)** havuzuna aktarılır[cite: 237, 253].

#### 1.3. Sinyal (Signal - S) Üretimi
[cite_start]Oyunun temel para birimidir[cite: 234]. Tüketilen gürültünün verimlilikle çarpımıyla elde edilir:
* [cite_start]`S_produced = N_consumed * F_eff`[cite: 70].
* [cite_start]Eğer `F_eff` (verimlilik) 1.0'dan küçükse, sistemde veri kaybı yaşanır[cite: 70].

#### 1.4. Farkındalık (Awareness - A) ve Hafıza (Memory - M)
* [cite_start]**Farkındalık:** Gürültü ve Sinyal gibi otomatik akmaz; yüklü miktarda Sinyal feda edilerek sentezlenir[cite: 72, 239]. [cite_start]Sentezleme maliyeti mevcut Farkındalık seviyesine göre **logaritmik** olarak artar[cite: 73].
* [cite_start]**Hafıza (Kapasite & Prestij):** Sistemin toplam Sinyal depolama sınırıdır (`M_cap`)[cite: 240, 241]. [cite_start]Ulu Çöküş (Prestige) sonrasında kazanılan kalıcı Hafıza puanları, oyun içi enflasyonu engellemek için mevcut Farkındalık / Sinyal toplamının **küp kök** (cube root) fonksiyonuna dayandırılacaktır[cite: 76]. [cite_start]Sonsuz puan kazanımını önlemek için bir sonraki prestijde anlamlı bir kazanım elde etmek adına 8 kat daha ileri gidilmesi zorunludur[cite: 77, 78].

### 2. MALİYET ARTIŞ EĞRİLERİ (COST SCALING) VE BULK BUY
[cite_start]İlerlemeli oyun ekonomisinin kırılmaması için maliyetler üstel (exponential) olarak artacaktır[cite: 80, 243]. [cite_start]Logaritmik maliyet artışları hiperenflasyon yaratacağı için KESİNLİKLE REDDEDİLMİŞTİR[cite: 244].

* [cite_start]**Standart Maliyet Formülü:** `Cost_n = Cost_base * (R)^k` [cite: 81]
    * `Cost_base`: 1. seviyedeki başlangıç maliyeti.
    * [cite_start]`R`: Büyüme katsayısı (Gürültü Jeneratörleri için `1.07`, Filtreler için `1.15`)[cite: 81, 246].
    * [cite_start]`k`: Oyuncunun mevcut seviyesi[cite: 81].

* [cite_start]**Maksimum Al (Bulk Buy) Geometrik Dizisi - O(1) Kuralı:** Ajan, "100x Al" veya "Maksimum Al" işlemleri için `while/for` döngüleri KULLANAMAZ[cite: 82, 248]. [cite_start]Toplam maliyet ve alınabilecek seviye hesaplamaları geometrik seri toplamı formülü kullanılarak `O(1)` sürede hesaplanacaktır[cite: 82, 249].

### 3. RİTİM VE KRİZ MEKANİKLERİ: OVERHEAT & MOMENTUM
[cite_start]Oyun, "idle" yapısını oyuncunun aktif müdahaleleriyle derinleştirir[cite: 84].

#### 3.1. Overheat (Aşırı Isınma) ve Termal Darboğaz
[cite_start]Sistemin darboğazı (bottleneck) aşıldığında işleyen ceza mekanizmasıdır[cite: 89, 252].
* [cite_start]`N_rate > F_rate` olan her saniye, aradaki fark Overheat havuzuna (`O_pool`) eklenir[cite: 90, 253].
* [cite_start]Havuzun maksimum tolerans sınırı (`O_max`), sistemin **Toplam Hafıza Kapasitesinin yalnızca %5'idir**[cite: 254].
* [cite_start]Havuz dolup %100 kapasiteye (`H_max`) ulaşıldığında sistem **Thermal Throttling** (Termal Darboğaz / Zorunlu Soğuma) fazına girer[cite: 92, 255].
* [cite_start]**Ceza:** Üretim verimliliği %10'a düşer (veya tamamen durur), tüm satın alım butonları kilitlenir, UI kırmızı uyarı verir ve ağır haptic titreşim tetiklenir[cite: 93, 94, 256]. [cite_start]Soğuma gerçekleşene kadar sistem kilitli kalır[cite: 94].

#### 3.2. Kusursuz Rezonans (Perfect Resonance)
[cite_start]Eğer oyuncu `N_rate` ve `F_rate` değerlerini birbirine **%99 ile %100** oranında eşitlerse, sistem Rezonans durumuna geçer[cite: 259].
* Bu süre boyunca her saniye (`t`), Sinyal üretimine logaritmik olarak büyüyen bir çarpan eklenir: 
    [cite_start]`M_resonance = 1 + log10(1 + t)`[cite: 260, 261].

#### 3.3. Aktif Momentum Çarpanı
[cite_start]Oyuncu terminale ritmik olarak dokunduğunda anlık üretim artar[cite: 85].
* [cite_start]**Momentum Artışı:** `Mom_curr = min(Mom_max, Mom_curr + (\Delta m * Q_click))`[cite: 87].
* [cite_start]**Sönümlenme (Decay):** Makrofobik (autoclicker) hileleri önlemek için, her döngüde momentum `\lambda` oranıyla azalır[cite: 86, 88]. [cite_start]Dokunuş kesildiğinde çarpan baz değere (1.0) geri döner[cite: 88].

### 4. ÇEVRİMDIŞI İLERLEME (OFFLINE PROGRESS) ALGORİTMASI
[cite_start]Veri katmanı aracılığıyla hesaplanan offline süre, oyun açıldığında tek bir kütlesel işlem (macro-calculation) olarak motoru beslemelidir[cite: 25, 251].
* [cite_start]Ajan, çevrimdışı geçen binlerce saniyeyi `Timer.periodic` ile tek tek döngüye sokmaya KESİNLİKLE ÇALIŞMAYACAKTIR[cite: 250].
* [cite_start]Geçen saniye (Delta) hesaplandıktan sonra, mevcut üretim hızları sabit kabul edilerek integral (veya delta x saniye çarpımı) ile **tekil, anlık bir matematik formülü** olarak (`O(1)`) oyuncunun bakiyesine eklenecektir[cite: 251].