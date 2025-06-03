# Coturn Setup (STUN → TURN Geçiş Rehberi)

Bu modül, başlangıçta kullanılan Google STUN yapılandırmasından, üretim ortamı için önerilen coturn (STUN + TURN sunucusu) kurulumuna geçişi anlatır. Ayrıca TLS ve şifreleme konfigürasyonları da içerir.

## 📦 Kullanılan Bileşenler

- Google STUN → `stun:stun.l.google.com:19302`
- Coturn (STUN + TURN open source sunucu)
- Ubuntu 20.04+ (veya benzeri Linux)
- Let’s Encrypt SSL sertifikası
- WebRTC şifreleme: SRTP, DTLS (istemcilerde varsayılan)

## ☁️ Google STUN Kullanımı (Test Ortamı)

```js
iceServers: [
  {
    urls: ["stun:stun.l.google.com:19302"],
  },
];
```

> Geçici, test ortamları için uygundur. TURN (relay) desteği yoktur.

## 🔁 STUN'dan Coturn'a Geçiş Planı

1. Coturn sunucusunu kur
2. Web/Mobil istemcilerde iceServers yapılandırmasını aşağıdaki gibi güncelle:

```js
iceServers: [
  {
    urls: ["turn:yourdomain.com:3478"],
    username: "user",
    credential: "token",
  },
  {
    urls: ["stun:stun.l.google.com:19302"],
  },
];
```

3. Test edip `turn:` bağlantısının aktif çalıştığını doğrula
4. Google STUN’u tamamen kaldır:

```js
iceServers: [
  {
    urls: ["turn:yourdomain.com:3478"],
    username: "user",
    credential: "token",
  },
];
```

5. Güvenlik ve sınırlandırmaları uygula: IP, token, kota

## 🛠️ Coturn Kurulumu

### 1. Kurulum

```bash
sudo apt update
sudo apt install coturn
```

### 2. Yapılandırma

`/etc/turnserver.conf` dosyasına şunları ekle:

```ini
listening-port=3478
tls-listening-port=5349
listening-ip=<SERVER_PUBLIC_IP>
relay-ip=<SERVER_PUBLIC_IP>
realm=yourdomain.com
fingerprint
total-quota=100
bps-capacity=0
stale-nonce
lt-cred-mech
use-auth-secret
static-auth-secret=your_static_secret
cert=/etc/letsencrypt/live/yourdomain.com/fullchain.pem
pkey=/etc/letsencrypt/live/yourdomain.com/privkey.pem
```

### 3. Servisi Başlat

```bash
sudo systemctl enable coturn
sudo systemctl restart coturn
```

## 🔐 Şifreleme

- SRTP: medya şifreleme
- DTLS: anahtar değişimi
- Tarayıcılar ve SDK’lar tarafından otomatik uygulanır
- Coturn `turns:` desteği ile TLS bağlantısı sağlar

```js
iceServers: [
  {
    urls: ["turns:yourdomain.com:5349"],
    username: "user",
    credential: "secure-token",
  },
];
```

## 🧪 Test

Trickle ICE ile test: https://webrtc.github.io/samples/src/content/peerconnection/trickle-ice/

## 🛡️ KVKK Uyum Notları

- Medya verileri SRTP ile şifrelenir
- Signaling yetkilendirmesi zorunlu (session/JWT)
- Türkiye/EU lokasyonlu sunucular kullanılmalı
- Rıza metni kamera/mikrofon izinlerinden önce sunulmalı
- IP ve cihaz bilgileri loglanıyorsa erişim kısıtlanmalı

## 📂 Yol Haritası

- [ ] Log dosyası tanımlama ve denetim
- [ ] Trafik kontrol paneli (opsiyonel)
- [ ] Token auth (RFC 5766)
- [ ] Sertifika yenileme otomasyonu
