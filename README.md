# 🍔 Flutter Food Ordering App

Modern mimari ve kullanıcı deneyimi odaklı geliştirilmiş bir **Flutter yemek sipariş uygulaması**.  
Uygulama; ürün listeleme, favoriler, sepet yönetimi ve animasyonlu splash ekranı içerir.

---

## 📱 Özellikler

- 🏠 Ürün listeleme (Grid yapısı)
- 🔍 Arama (real-time filtreleme)
- ❤️ Favori ürünler
- 🛒 Sepet yönetimi
  - Ürün ekleme / silme
  - Adet artırma / azaltma
  - Toplam fiyat hesaplama
- 🎬 Lottie animasyonlu Splash Screen
- 📦 Clean Architecture (Entity – Repository – Cubit)
- 🎨 Modern & minimal UI

---

## 🧠 Kullanılan Teknolojiler

### 🚀 Core
- **Flutter (Dart)**
- **Material Design**

### 🧩 State Management
- **flutter_bloc (Cubit)**  
  - `HomeCubit`
  - `FavoritesCubit`
  - `CartCubit`

### 📦 Architecture
- **Clean Architecture**
  - `data`
    - `entity`
    - `repositories`
  - `ui`
    - `cubit`
    - `views`

### 🌐 Network
- **RESTful API**
- **Dio**
- JSON parsing (Model & Response yapıları)

### 🎞 Animasyon
- **Lottie**
  - Splash screen animasyonu (`json` asset)

---

## 🎨 UI / UX Yaklaşımı

- Soft gri arkaplan (`#F5F6FA`)
- Ana tema rengi: **Deep Purple**
- Kart bazlı tasarım
- Rounded corners & shadow
- Sabit bottom total bar (Cart)
- Kullanıcı dostu minimal tasarım

---

