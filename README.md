# MockaVerse iOS

MockaVerse web uygulamasının iOS mobil versiyonu. SwiftUI kullanılarak geliştirilmiş modern bir iOS uygulamasıdır.

## Özellikler

### 📱 Ana Özellikler
- **Senaryo Yönetimi**: Senaryo oluşturma, düzenleme, silme
- **Mock Servis Tanımlama**: Her senaryo için detaylı mock servis yapılandırması
- **Müşteri Yönetimi**: Müşteri oluşturma ve düzenleme
- **Senaryo-Müşteri Eşleştirme**: Müşterilere senaryo atama ve kaldırma
- **Arama ve Filtreleme**: Senaryo ve müşteri arama işlevselliği
- **Offline Destek**: Core Data ile yerel veri saklama

### 🎨 Kullanıcı Arayüzü
- Modern SwiftUI tasarımı
- iOS 15+ uyumluluğu
- Dark Mode desteği
- iPad uyumluluğu
- Responsive tasarım

### 🏗️ Teknik Özellikler
- **Mimari**: MVVM (Model-View-ViewModel)
- **UI Framework**: SwiftUI
- **Veri Yönetimi**: Core Data + Network Layer
- **Network**: URLSession + Combine
- **Minimum iOS Sürümü**: iOS 15.0

## Proje Yapısı

```
MockaVerse/
├── Models/                 # Veri modelleri
│   ├── Scenario.swift
│   ├── Customer.swift
│   └── MockService.swift
├── Views/                  # SwiftUI görünümleri
│   ├── ScenarioListView.swift
│   ├── ScenarioDetailView.swift
│   ├── CustomerListView.swift
│   └── CustomerDetailView.swift
├── ViewModels/            # MVVM view modelleri
│   ├── ScenarioViewModel.swift
│   └── CustomerViewModel.swift
├── Services/              # Servis katmanı
│   ├── NetworkManager.swift
│   └── CoreDataManager.swift
├── Assets.xcassets/       # Görsel varlıklar
└── MockaVerse.xcdatamodeld # Core Data modeli
```

## Kurulum

### Gereksinimler
- Xcode 15.0+
- iOS 15.0+
- macOS 13.0+ (geliştirme için)

### Adımlar

1. **Projeyi Xcode'da Açın**
   ```bash
   open MockaVerse.xcodeproj
   ```

2. **Hedef Cihazı Seçin**
   - iPhone/iPad simülatörü veya fiziksel cihaz

3. **Projeyi Çalıştırın**
   - ⌘ + R tuşlarına basın veya "Run" butonuna tıklayın

## API Entegrasyonu

Uygulama, web versiyonuyla aynı backend API'yi kullanır:

### Endpoint'ler
- `GET /api/scenarios` - Senaryoları listele
- `POST /api/scenarios` - Yeni senaryo oluştur
- `PUT /api/scenarios/:id` - Senaryo güncelle
- `DELETE /api/scenarios/:id` - Senaryo sil
- `GET /api/customers` - Müşterileri listele
- `POST /api/customers` - Yeni müşteri oluştur
- `PUT /api/customers/:id` - Müşteri güncelle
- `DELETE /api/customers/:id` - Müşteri sil

### Yapılandırma
`NetworkManager.swift` dosyasında base URL'i değiştirin:
```swift
private let baseURL = "http://your-server-url:5000/api"
```

## Kullanım

### Senaryo İşlemleri

1. **Yeni Senaryo Ekleme**
   - "Senaryolar" sekmesine gidin
   - "+" butonuna tıklayın
   - Senaryo bilgilerini girin
   - Mock servisleri ekleyin
   - "Kaydet" butonuna tıklayın

2. **Senaryo Düzenleme**
   - Senaryo listesinden bir senaryoya tıklayın
   - "Düzenle" butonuna tıklayın
   - Değişiklikleri yapın ve kaydedin

### Müşteri İşlemleri

1. **Yeni Müşteri Ekleme**
   - "Müşteriler" sekmesine gidin
   - "+" butonuna tıklayın
   - Müşteri bilgilerini girin
   - "Kaydet" butonuna tıklayın

2. **Senaryo Atama**
   - Müşteri detayına gidin
   - "Senaryo Ata" butonuna tıklayın
   - Atamak istediğiniz senaryoyu seçin

## Geliştirme

### Yeni Özellik Ekleme

1. **Model Güncellemesi**
   - Gerekirse `Models/` klasöründe veri modellerini güncelleyin

2. **View Model Güncellemesi**
   - `ViewModels/` klasöründe iş mantığını ekleyin

3. **View Oluşturma**
   - `Views/` klasöründe SwiftUI görünümlerini oluşturun

4. **Network Entegrasyonu**
   - `NetworkManager.swift`'te API çağrılarını ekleyin

### Test Etme

```bash
# Unit testleri çalıştırma
⌘ + U

# UI testleri çalıştırma
⌘ + Shift + U
```

## Sorun Giderme

### Yaygın Sorunlar

1. **Build Hatası**
   - Xcode'u yeniden başlatın
   - Derived Data'yı temizleyin: `⌘ + Shift + K`

2. **Network Bağlantı Sorunu**
   - Backend sunucusunun çalıştığından emin olun
   - `NetworkManager.swift`'te base URL'i kontrol edin

3. **Core Data Hatası**
   - Simülatörü sıfırlayın
   - Uygulamayı yeniden yükleyin

## Katkıda Bulunma

1. Fork yapın
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Değişikliklerinizi commit edin (`git commit -m 'Add amazing feature'`)
4. Branch'inizi push edin (`git push origin feature/amazing-feature`)
5. Pull Request oluşturun

## Lisans

Bu proje MIT lisansı altında dağıtılmaktadır. Detaylar için `LICENSE` dosyasına bakın.

## İletişim

Sorularınız için: example@example.com

---

**Not**: Bu uygulama MockaVerse web uygulamasının mobil versiyonudur ve aynı backend API'yi kullanır.