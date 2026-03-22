# 🌾 Tarım Asistan

**Toprak analizi ve tarım rehberi** mobil uygulaması. Flutter ile **geliştirilmektedir** — proje şu an **yapım aşamasındadır**. Hedef: Kullanıcıların toprak türleri hakkında bilgi alması, fotoğraf çekerek toprak analizi yapması ve hangi toprakta hangi bitkilerin yetişeceğini öğrenmesi.

---

## 📌 Proje durumu

🟡 **Yapım aşamasında** — Uygulama iskeleti ve ekranlar hazır; Firebase bağlantısı, Firestore verileri ve AI model entegrasyonu üzerinde çalışılıyor.

---

## ✨ Hedeflenen özellikler

- **Toprak Türleri** — Killi, kumlu, tınlı, kireçli vb. toprak türlerini inceleme; renk, pH, su tutma ve havalanma bilgileri
- **Fotoğrafla Tanı** — Toprak fotoğrafı çekerek veya galeriden seçerek yapay zeka ile toprak türü tespiti
- **Bitki Rehberi** — Kategoriye göre (sebze, meyve, tahıl, ağaç) filtreleme; her bitki için uygun topraklar, ekim/hasat zamanları ve bakım ipuçları
- **Türkçe arayüz** — Tamamen Türkçe dil desteği

---

## 🛠 Kullanılan Teknolojiler

| Alan | Teknoloji |
|------|-----------|
| Çerçeve | Flutter (Dart) |
| Veritabanı | Firebase Firestore |
| Görsel seçimi | image_picker (kamera & galeri) |
| Toprak tanıma | TensorFlow Lite / Teachable Machine |
| Görsel önbellekleme | cached_network_image |
| Tipografi | google_fonts |

---

## 📱 Uygulama yapısı (planlanan / geliştirilen)

1. **Ana Sayfa** — Gradient yeşil arka plan, logo ve 3 ana menü kartı (Toprak Türleri, Fotoğrafla Tanı, Bitki Rehberi)
2. **Toprak Listesi** — Firestore’dan toprak türleri; kartlarda görsel, ad, renk, pH
3. **Toprak Detay** — SliverAppBar, özellikler, avantaj/dezavantaj listeleri, o toprakta yetişen bitkiler (yatay liste)
4. **Fotoğrafla Tanı** — Kamera veya galeriden seçim, analiz sonrası sonuç sayfasına yönlendirme
5. **Sonuç Sayfası** — Tespit edilen toprak, güven yüzdesi, önerilen bitkiler, “Detaylı Bilgileri Gör” butonu
6. **Bitki Rehberi** — Kategori chip’leri (Tümü, Sebze, Meyve, Tahıl, Ağaç) ve 2 sütunlu grid; bitkiye dokununca **bitki detay** (pH/su ihtiyacı, ekim–hasat, uygun topraklar, bakım ipuçları)

---

## 🚀 Kurulum

### Gereksinimler

- Flutter SDK (3.0+)
- Firebase projesi
- Android Studio / VS Code (isteğe bağlı)

### Adımlar

1. **Projeyi klonlayın**
   ```bash
   git clone https://github.com/mehmeteminyilmaz/TarimAsistan.git
   cd TarimAsistan
   ```

2. **Bağımlılıkları yükleyin**
   ```bash
   flutter pub get
   ```

3. **Firebase’i bağlayın**
   - [Firebase Console](https://console.firebase.google.com) üzerinden yeni proje oluşturun
   - Android uygulaması ekleyin (paket adı: `com.example.tarim_asistan`)
   - İndirdiğiniz `google-services.json` dosyasını `android/app/` klasörüne koyun

4. **Firestore verilerini ekleyin**
   - `toprak_turleri` koleksiyonu: toprak türü dökümanları (ad, renk, ph_aralik, su_tutma, havalanma, avantajlar, dezavantajlar, resim_url vb.)
   - `bitkiler` koleksiyonu: bitki dökümanları (ad, kategori, uygun_topraklar, ekim_zamani, hasat_zamani, resim_url, bakim_ipuclari vb.)

5. **Uygulamayı çalıştırın**
   ```bash
   flutter run
   ```

6. **Windows’ta kablosuz deneme (Firebase olmadan)**  
   Firebase başlatılamazsa veya Firestore boş/hatalıysa uygulama otomatik olarak `lib/data/yerel_ornek_veriler.dart` içindeki **örnek toprak ve bitki** verilerini kullanır. Tam deneyim için:
   ```bash
   flutter run -d windows
   ```

> **Not:** AI toprak tanıma için `assets/model.tflite` dosyasını Teachable Machine veya TensorFlow Lite ile eğitip `pubspec.yaml` içindeki assets listesine eklemeniz gerekir. Model yoksa “Fotoğrafla Tanı” yine **demo sonuç** üretebilir.

---

## 📱 Android Studio SDK yolu ve fiziksel telefon

### Neden `C:\Android\Sdk`?

Kullanıcı klasörünüzde boşluk varsa (`mehmet emin yılmaz`), Android Studio’nun önerdiği yol şuna benzer olabilir:

`C:\Users\...\AppData\Local\Android\Sdk`

Bu yolda **boşluk** olduğu için kurulumda **“SDK location should not contain whitespace”** uyarısı çıkar; NDK ve bazı araçlarda sorun çıkabilir.

**Öneri:** Tek bir SDK kullanın ve yolu **boşluksuz** tutun. Bu projede `android/local.properties` şu şekilde ayarlıdır:

- `sdk.dir=C:\\Android\\Sdk`

Android Studio’da **File → Settings → Languages & Frameworks → Android SDK** bölümünde **Android SDK Location** olarak `C:\Android\Sdk` seçili olsun (sihirbazda farklı bir yol gösteriyorsa **Edit** ile değiştirin).

### `adb` komutu tanınmıyorsa

`adb` genelde şu klasördedir:

`C:\Android\Sdk\platform-tools\adb.exe`

PowerShell’de tam yol ile:

```powershell
& "C:\Android\Sdk\platform-tools\adb.exe" kill-server
& "C:\Android\Sdk\platform-tools\adb.exe" start-server
& "C:\Android\Sdk\platform-tools\adb.exe" devices
```

Kalıcı kullanım için Windows **Ortam değişkenleri → Path** içine şunu ekleyin:

`C:\Android\Sdk\platform-tools`

### Telefon `not authorized` / `offline`

1. Telefonda **USB hata ayıklama** açık olsun; kabloyu takınca **“USB hata ayıklamaya izin ver?”** penceresinde **İzin ver** deyin.
2. USB modu: **Dosya aktarımı (MTP)** — sadece şarj değil.
3. Gerekirse **Geliştirici seçenekleri → USB üzerinden yetkilendirmeleri iptal et**, kabloyu çıkarıp tekrar takın.
4. `adb devices` çıktısında cihaz **`device`** olmalı; ardından `flutter devices` ve `flutter run -d <cihaz_id>`.

---

## 📂 Firestore Koleksiyon Yapısı

### toprak_turleri

| Alan | Tür | Açıklama |
|------|-----|----------|
| ad | string | Toprak türü adı |
| renk | string | Renk bilgisi |
| ph_aralik | string | pH aralığı |
| su_tutma | string | Su tutma kapasitesi |
| havalanma | string | Havalanma bilgisi |
| ozellikler | string | Genel özellikler |
| avantajlar | array | Avantaj listesi |
| dezavantajlar | array | Dezavantaj listesi |
| resim_url | string | Görsel URL |

### bitkiler

| Alan | Tür | Açıklama |
|------|-----|----------|
| ad | string | Bitki adı |
| kategori | string | sebze, meyve, tahil, agac |
| uygun_topraklar | array | Toprak döküman ID’leri |
| ph_ihtiyaci | string | pH ihtiyacı |
| su_ihtiyaci | string | Su ihtiyacı |
| ekim_zamani | string | Ekim dönemi |
| hasat_zamani | string | Hasat dönemi |
| resim_url | string | Görsel URL |
| bakim_ipuclari | array | Bakım ipuçları |

---

## 📄 Lisans

Bu proje eğitim ve kişisel kullanım amaçlıdır.

---

**Tarım Asistan** — Toprağını tanı, verimini artır. *(Yapım aşamasında)*
