# WebRTC Görüntülü Görüşme Platformu (Web ⇄ Mobil)

Kurumsal kullanım için geliştirilen bu sistem, doktor ve hasta arasında mobil ve web istemcileriyle uçtan uca şifreli görüntülü görüşme sağlamayı hedefler.

## 🧱 Genel Mimari

```
[ Mobil Client ] ←→         ←→ [ Web Client ]
     RN / WebRTC               React / WebRTC
         │                          │
         ▼                          ▼
   [ Signaling Server ] (Spring Boot / WebSocket)
               │
               ▼
        [ coturn Server (TURN/STUN) ]
               │
               ▼
     [ Peer to Peer Medya Bağlantısı ]
```

## 📦 Modüller

| Modül                                     | Açıklama                                           |
| ----------------------------------------- | -------------------------------------------------- |
| [signaling-server](./signaling-server.md) | WebSocket tabanlı signaling sunucusu (Spring Boot) |
| [web-client](./web-client.md)             | Tarayıcıdan görüntülü görüşme (React)              |
| [mobile-client](./mobile-client.md)       | Mobil uygulama ile görüşme (React Native)          |
| [coturn-setup](./coturn-setup.md)         | STUN'dan TURN'a geçiş, coturn kurulumu, şifreleme  |

## 🔐 Güvenlik ve KVKK

- WebRTC medya trafiği: SRTP + DTLS ile şifrelenir
- Signaling: oturum bazlı Spring Security auth
- TURN sunucusu TLS desteklidir (`turns:` protokolü)
- KVKK gereği: açık rıza ekranı, log denetimi, yerel sunucu

## 🔁 Kullanım Akışı

1. [Signaling Server](./signaling-server.md) kurulumu
2. [Web Client](./web-client.md) ile ilk bağlantı testleri
3. [Mobile Client](./mobile-client.md) üzerinden eşleşme
4. [Coturn Server](./coturn-setup.md) devreye alınır, Google STUN kaldırılır
5. KVKK ve TLS testleriyle yayına alınır

## 🧭 Notlar

- Oda tabanlı değil, rol bazlı eşleştirme (doktor-hasta)
- Doktorlar web veya mobilden bağlanabilir
- Hastalar yalnızca mobilden katılır
- Sunucular Avrupa veya Türkiye lokasyonunda olmalıdır

## 🗂 Alt Rehberler

- [signaling-server.md](./signaling-server.md)
- [web-client.md](./web-client.md)
- [mobile-client.md](./mobile-client.md)
- [coturn-setup.md](./coturn-setup.md)
