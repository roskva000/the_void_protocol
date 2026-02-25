# MODÜL 3: UI_UX_AND_HAPTICS.md
## THE VOID PROTOCOL - GÖRSEL DİL, ARAYÜZ VE DOKUNSAL GERİBİLDİRİM KILAVUZU

Bu doküman, oyunun görsel ve fiziksel iletişim katmanını tanımlar. "The Void Protocol", oyuncuyu görsel bir şölenle değil; akıcı sayılar, kusursuz bir minimalizm ve derin dokunsal geribildirimlerle (haptics) hipnotize etmeyi amaçlar. Otonom kodlama ajanı, arayüzü inşa ederken hiçbir 3D asset, resim dosyası (.png/.jpg) veya karmaşık vektörel çizim (SVG) kullanmayacak; her şeyi Flutter'ın yerel (native) `CustomPaint`, `BackdropFilter` ve tipografi motoru ile kodlayacaktır.

### 1. RENK PALETİ (KATI HEX KODLARI)
Arayüz, uzayın sonsuzluğunu ve endüstriyel bir terminalin soğukluğunu yansıtmalıdır. Ajan, bu HEX kodlarını global bir `AppColors` sınıfında `static const Color` olarak tanımlamalıdır.
* **Deep Charcoal (Derin Zemin):** `#1F2227` - Ekranın en alt katmanı, arka plan.
* **Muted Slate (Cam Arka Plan):** `#2B2B2E` - Modalların ve cam panellerin baz rengi.
* **Void Neon Blue (Birincil Enerji/Sinyal):** `#00C2FF` - Üretim barları, aktif butonlar ve Sinyal metinleri. Işıma (Glow) efekti için `BoxShadow` ile desteklenmelidir.
* **Rusted Bronze (Uyarı / Overheat / Prestige):** `#A0693D` - Tehlike, Aşırı Isınma barları ve Ulu Çöküş (Prestige) elementleri.
* **Frost White (Ana Tipografi):** `#F2F2F2` - Vurgulanması gereken ana metinler ve sayılar.
* **Ash Grey (Pasif Tipografi):** `#8A8F98` - Hikaye logları, pasif butonlar ve alt başlıklar.

### 2. TİPOGRAFİ VE SAYI AKIŞI YASALARI
Oyunun büyük bir kısmı hızla değişen sayılara bakmaktan ibarettir. Bu nedenle metinlerin işlenmesi kritik bir UI/UX problemidir.
* **Monospace Zorunluluğu:** Saniyede 60 kez güncellenen kaynak sayılarında (Gürültü, Sinyal vb.) kesinlikle `Space Mono` veya `JetBrains Mono` gibi eşaralıklı (monospace) fontlar kullanılacaktır. Aksi takdirde, "1" ve "8" gibi rakamların piksel genişlikleri farklı olduğu için metinlerde yatay titreme (horizontal jittering) yaşanır.
* **Hikaye Fontu:** Diyaloglar ve felsefi log kayıtları için ince (Light/Regular weight) `Inter` veya `Roboto` kullanılmalıdır.
* **Sayısal Akıcılık (Number Rolling):** Bir sayının örneğin 1.000'den 5.000'e çıkması durumunda metin aniden değişmeyecektir. Ajan, `TweenAnimationBuilder` (veya eşdeğer bir lerp algoritması) kullanarak sayıların yuvarlanarak (rolling) artmasını sağlamalıdır.

### 3. "GLASSMORPHISM" KOD REÇETESİ VE PERFORMANS
Kullanılacak tüm paneller (Filtre yükseltme kutuları, istatistik kartları) "Buzlu Cam" (Glassmorphism) efektine sahip olacaktır. Ancak `BackdropFilter` performansı ağır şekilde etkilediği için aşağıdaki kurallar zorunludur:
* **RepaintBoundary İzolasyonu:** İçindeki sayılar saniyede 60 kez değişen tüm cam paneller, kesinlikle `RepaintBoundary` widget'ı ile sarılmalıdır. Böylece Flutter, sadece sayıyı yeniden çizer, tüm cam efektini (blur) baştan hesaplamaz.
* **Blur (Bulanıklık) Değerleri:** `ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0)`.
* **Konteyner Opaklığı:** Zemin rengi `Colors.white.withOpacity(0.05)` (Çok hafif beyaz bir yansıma).
* **Border (Çerçeve) İllüzyonu:** Işığın üstten geldiğini simüle etmek için kutuların kenarlıklarına asimetrik gradient verilmelidir:
  * Üst ve Sol Kenar: `Colors.white.withOpacity(0.15)` (1px)
  * Alt ve Sağ Kenar: `Colors.white.withOpacity(0.02)` (1px)

### 4. DOKUNSAL GERİBİLDİRİM (HAPTIC FEEDBACK) SÖZLÜĞÜ
Bu oyunda ses tasarımı asgari düzeydedir; oyuncunun sistemle bağı, cihazın titreşim motoru üzerinden kurulur. Ajan, `haptic_feedback` (veya eşdeğeri Flutter paketleri) kullanarak şu kesin senaryoları entegre edecektir:
* **Sekme / Menü Geçişleri:** Çok hafif bir dokunuş hissi. Sadece `HapticFeedback.selectionClick()`.
* **Sıradan Satın Alımlar:** Jeneratör veya Filtre alındığında tatmin edici, tok bir klik. `HapticFeedback.lightImpact()`.
* **Kilidi Açılan Aşama (Milestone / Story Unlock):** Ekranın yeni bir faza geçtiğini hissettiren derin titreşim. `HapticFeedback.mediumImpact()`.
* **Momentum Ritimleri:** Oyuncu "Kusursuz Rezonans" çarpanını artırmak için manuel tıkladığında, çarpan büyüdükçe titreşim şiddeti ve hızı logaritmik olarak `light` seviyesinden `medium` seviyesine ölçeklenmelidir (Ritim hissi).
* **Overheat (Aşırı Isınma) Uyarı ve Çöküş:**
  * Bar %90'a ulaştığında uyarı atımları: 500ms boşlukla ardışık 3 kez `HapticFeedback.heavyImpact()`.
  * Sistem kilitlendiğinde (Thermal Throttling) veya "Ulu Çöküş" (Prestige) tetiklendiğinde: Adeta cihazın elde patladığını hissettiren 1 tam saniyelik uzun `vibrate()` metodu çağrılmalıdır.

### 5. ANİMASYON VE EKRAN GEÇİŞ KURALLARI
* **Keskin Geçiş Yasakları:** UI üzerinde hiçbir element "pat" diye belirmeyecektir (Pop-in). Yeni açılan paneller, butonlar veya hikaye logları `AnimatedOpacity` kullanılarak 600ms - 1200ms arasında yavaşça belirmelidir (Fade-in).
* **Nefes Alma (Breathing) Efekti:** Sistem Kusursuz Rezonans'ta (%99-%100 eşik) çalışırken, Sinyal barlarının Neon Mavi parlaması saniyede bir kez hafifçe genleşip küçülmeli (Pulse/Breathing efekti), sistemin canlı bir organizma gibi hissettirmesi sağlanmalıdır.