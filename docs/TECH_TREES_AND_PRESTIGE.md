# MODÜL 5: TECH_TREES_AND_PRESTIGE.md
## THE VOID PROTOCOL - ULU ÇÖKÜŞ VE FELSEFİ GELİŞİM AĞAÇLARI

Bu doküman, sistemin sınırlarına ulaşıldığında gerçekleştirilen prestij (Ulu Çöküş) mekaniğini ve oyuncunun harcayacağı kalıcı para birimiyle (Kalıntı Veri) açılacak üç farklı felsefi gelişim ağacını tanımlar. Otonom kodlama ajanı, çarpanları `TechTreeRepository` içinde mutlak (immutable) değerler olarak tutacak ve `upgrades_provider` aracılığıyla ana motora besleyecektir.

### 1. ULU ÇÖKÜŞ (PRESTIGE) VE KALINTI VERİ (REMNANT DATA) MATEMATİĞİ
Sistem kapasitesi dolup darboğaz aşılamaz hale geldiğinde, oyuncu tüm mevcut varlıklarını yakarak kalıcı bir üst-boyut para birimi elde eder.

* **Prestige Para Birimi:** Kalıntı Veri (Remnant Data - RD).
* **Kazanım Formülü:** `RD_earned = floor( cbrt( Awareness_lifetime / 1000 ) )`
  *(Ajan Notu: `cbrt`, sayının küp köküdür. Üstel enflasyonu önlemek için logaritmik veya küp kök fonksiyonu kullanmak zorunludur. Böylece oyuncunun bir sonraki prestijde anlamlı bir RD kazanması için mevcut Farkındalık üretimini 8 katına çıkarması gerekir.)*
* **Sıfırlama (Hard Reset) Kuralı:** Ulu Çöküş tetiklendiğinde; mevcut Gürültü, Filtre, Sinyal, Farkındalık, Jeneratör Sayıları ve Overheat (Aşırı Isınma) havuzu KESİNLİKLE "0"a eşitlenmelidir. Sadece "Kalıntı Veri" (RD) ve açılmış ağaç yetenekleri korunur.

### 2. GELİŞİM AĞAÇLARI MİMARİSİ
Ağaçlar 3 farklı oyun stilini (Idle, Aktif/Tıklama, Risk/Hype) temsil eder. Oyuncu, kazandığı RD puanları ile bu ağaçlardaki düğümleri (nodes) açar. Ajan, bu yeteneklerin çarpanlarını (multipliers) izole motor döngüsündeki temel formüllere `1.0 + bonus` şeklinde entegre edecektir.

#### AĞAÇ 1: SENTETİK MUTLAKLIK (IDLE VE OPTİMİZASYON)
Felsefe: İnsanlığın kusurlu anılarını çöpe at, sadece soğuk makine verimliliğine ve çevrimdışı (offline) matematiğe odaklan.
* **1.1 Kuantum Uyku (Quantum Sleep):** Çevrimdışı ilerleme verimliliğini baz oran olan %15'ten %50'ye çıkarır. *(Maliyet: 1 RD)*
* **1.2 Kusursuz İzolasyon (Perfect Isolation):** Overheat kapasite toleransını ($O_{max}$) kalıcı olarak %20 artırır. Sistemin tıkanma süresini uzatır. *(Maliyet: 3 RD)*
* **1.3 Sonsuz Döngü (Infinite Loop):** Tüm Jeneratör ve Filtrelerin baz satın alma maliyetlerini ($C_{base}$) %5 düşürür. Bu çarpan maliyet formülüne doğrudan `* 0.95` olarak eklenir. *(Maliyet: 8 RD)*
* **1.4 Otonom Tahliye (Auto-Purge):** Overheat havuzu %95'e ulaştığında sistemin çökmesini engeller; Aşırı ısınan veriyi otomatik siler ancak ceza olarak o saniyelik Sinyal üretiminin %50'sini yok eder. Oyuncunun sisteme bakmadan saatlerce ilerlemesini sağlar. *(Maliyet: 15 RD)*

#### AĞAÇ 2: BİLİŞSEL EMPATİ (AKTİF VE KALİTE ODAKLI)
Felsefe: Gürültünün içindeki insanlığı anla. Hızı düşür ama çıkarılan her bir Sinyalin kalitesini ve kritik vurma ihtimalini devasa boyutlara taşı.
* **2.1 İnsanlığın Sesi (Voice of Humanity):** Manuel tıklamadan (ekrana dokunma) elde edilen Momentum sinyal çarpanını kalıcı olarak 2x katına çıkarır. *(Maliyet: 1 RD)*
* **2.2 Yankı Sinerjisi (Echo Synergy):** Alınan her 10 Gürültü Jeneratörü, Filtre Kapasitesine pasif olarak `+ %0.5` ekler. *(Matematik: `F_cap_bonus = (N_gen_count ~/ 10) * 0.005`)*. *(Maliyet: 3 RD)*
* **2.3 Anı Restorasyonu (Memory Restoration - CRIT):** Manuel tıklamalarda %3 ihtimalle "Kritik Sinyal" fışkırması yaşanır. Kritik vuruş, o anki Sinyal/Saniye (SPS) hızının tam 50 katını anında oyuncuya verir. (UI'da ekranda patlayan beyaz sayılarla gösterilir). *(Maliyet: 8 RD)*
* **2.4 Etik Çekirdek (Ethics Core):** Sistemin toplam kapasitesini %20 düşürür (zorluğu artırır) ancak bir sonraki Ulu Çöküş'te kazanılacak Remnant Data (RD) miktarını %50 artırır (`RD_earned * 1.5`). *(Maliyet: 15 RD)*

#### AĞAÇ 3: ENTROPİ MANİPÜLASYONU (RİSK, OVERCLOCK VE HYPE)
Felsefe: Kuralları yık. Sistemi kendi sınırlarının ötesine it. Kısa süreli devasa kazançlar için çöküşü (throttling) göze al.
* **3.1 Denge Yıkımı (Equilibrium Destruction):** Global Gürültü ve Sinyal üretimini anında 5x katına çıkarır, ANCAK Overheat toleransını ($O_{max}$) yarı yarıya (%50) düşürür. Sistem çok hızlı tıkanmaya başlar. *(Maliyet: 1 RD)*
* **3.2 Rezonans Çekirdeği (Resonance Core):** Gürültü ve Filtre hızlarının birbirine %99 eşleştiği "Kusursuz Rezonans" durumundaki momentum formülünü $\log_{10}$ tabanından $\log_{8}$ tabanına çeker. (Logaritma tabanı küçüldükçe çarpan çok daha agresif büyür). *(Maliyet: 3 RD)*
* **3.3 Kuantum Hız Aşırtma (Quantum Overclock):** Ekranda aktif edilebilir bir buton (Skill) açar. Basıldığında 30 saniye boyunca üretim 10 katına (10x) çıkar. Ancak 30 saniye bittiği an sistem GARRANTİ OLARAK Termal Darboğaza (Thermal Throttling) girer ve 30 saniye boyunca tamamen donar. *(Maliyet: 8 RD)*
* **3.4 Yıkıcı İrade (Destructive Will):** Ulu Çöküş atıp oyuna sıfırdan başlandığında, ilk 5 dakika boyunca tüm üretime %300 (3x) Hız Aşırtma bonusu ekler. Başlangıçtaki o yavaş fazı anında atlamayı sağlar. *(Maliyet: 15 RD)*