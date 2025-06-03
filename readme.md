# Web ⇄ Mobil WebRTC Görüntülü Görüşme Altyapısı

Kurumsal düzeyde, Web (React) ile Mobil (React Native) cihazlar arasında WebRTC tabanlı, güvenli ve esnek bir görüntülü görüşme altyapısı kurmak için hazırlanan proje planıdır.

---

## 🔧 Teknoloji Yığını

| Katman           | Teknoloji             |
| ---------------- | --------------------- |
| Mobil            | React Native + WebRTC |
| Web              | React.js + WebRTC     |
| Signaling Server | Node.js + Socket.IO   |
| STUN Server      | Google STUN           |
| Şifreleme        | WebRTC SRTP           |

> İlk aşamada Google STUN kullanılacak, ancak üretim ortamında `coturn` kurulması şiddetle önerilir.

---

## 🧩 Mimari Diyagram

```
+-------------------+                         +-------------------+
| Mobil (ReactNative)|                       | Web (React)        |
| - react-native-webrtc|                     | - simple-peer      |
+-------------------+                       +-------------------+
        |                                          |
        |----------- WebSocket Signaling ----------|
        |       (Node.js + Socket.IO server)       |
        |                                          |
        |------------- Google STUN ----------------|
        |   (stun:stun.l.google.com:19302)         |
        |                                          |
        |---------- WebRTC Peer-to-Peer -----------|
        |        (Ses & Görüntü Akışı - SRTP)      |
```

---

## 🔁 Bağlantı Akışı

1. Kullanıcılar Socket.IO ile ortak oda ID'siyle signaling sunucusuna bağlanır.
2. Web istemci offer oluşturur, signaling sunucusuna gönderir.
3. Mobil istemci offer'ı alır, answer oluşturup gönderir.
4. ICE candidate'lar karşılıklı paylaşılır.
5. STUN üzerinden bağlantı kurulur, medya P2P olarak akar.

---

## 🏗️ Bileşenlere Göre Sorumluluklar ve Plan

### 1. STUN/TURN Sunucusu (coturn – ileride)

- **Sorumlu:** DevOps
- `coturn` kurulumu ve yapılandırması
- TLS sertifikası, auth-secret, realm tanımı
- Portlar: 3478 (UDP), 5349 (TLS)

### 2. Signaling Server (Node.js + Socket.IO)

- **Sorumlu:** Backend geliştirici
- Oda yönetimi ve WebSocket mesajlaşması
- offer/answer/candidate iletimi

### 3. Web Client (React.js)

- **Sorumlu:** Frontend geliştirici (web)
- Kamera/mikrofon erişimi
- WebRTC bağlantısı (simple-peer)
- ICE server tanımı ve signaling bağlantısı

### 4. Mobil Client (React Native)

- **Sorumlu:** Mobil geliştirici
- Kamera/mikrofon izinleri (iOS/Android)
- WebRTC entegrasyonu (`react-native-webrtc`)
- Signaling ve medya akışı yönetimi

---

## ⚠️ Dikkat Edilecekler

- Google STUN geçici çözüm, üretimde coturn kullanılmalı
- Signaling sunucusu kimlik doğrulama ile korunmalı
- Tüm medya SRTP ile şifrelenmiş olsa da relay fallback için TURN altyapısı kritik

---

## ▶️ Başlangıç Önerisi

İlk olarak aşağıdakilerden biriyle başlanmalı:

- [ ] Signaling sunucusu kurulumu (Node.js + Socket.IO)
- [ ] Web istemci geliştirimi (React)
- [ ] Mobil istemci geliştirimi (React Native)
- [ ] coturn kurulum dosyası (geleceğe hazırlık)
