# WebRTC Görüntülü Görüşme Platformu (Web ⇄ Mobil)

Kurumsal kullanım için tasarlanmış, doktor ve hasta rollerine dayalı, mobil ve web istemcileri arasında WebRTC üzerinden görüntülü görüşme yapılmasını sağlayan modüler sistem.

---

## 🏗️ Mimaride Yer Alan Modüller

| Modül                                     | Açıklama                                                |
| ----------------------------------------- | ------------------------------------------------------- |
| [signaling-server](./signaling-server.md) | Spring Boot WebSocket tabanlı signaling servisi         |
| [web-client](./web-client.md)             | React ile WebRTC tabanlı web istemci                    |
| [mobile-client](./mobile-client.md)       | React Native ile mobil istemci                          |
| [coturn-setup](./coturn-setup.md)         | STUN'dan TURN'a geçiş, coturn kurulumu, TLS & şifreleme |

---

## 🔒 Güvenlik ve KVKK

- SRTP + DTLS şifreleme ile medya güvenliği
- Session bazlı authentication (Spring Security)
- TLS destekli TURN sunucusu (coturn)
- Kamera/mikrofon erişimi öncesi açık rıza metni
- Veriler Türkiye/Avrupa lokasyonlu sunucularda barındırılmalı

---

## 🧭 Kullanım Sırası

1. [Signaling Server](./signaling-server.md) kur
2. [Web Client](./web-client.md) ile bağlantıyı test et
3. [Mobile Client](./mobile-client.md) ile eşleşmeyi çalıştır
4. [coturn Setup](./coturn-setup.md) ile STUN → TURN geçişi yap
5. KVKK & TLS kontrolleri ile yayına al

---

## ⚙️ Sistem Özeti

- WebRTC: peer-to-peer medya iletimi
- Doktor–Hasta eşleşmesi: oda değil, rol bazlıdır
- Mobil: izinler ve rıza ekranı ile başlar
- Sunucular: signaling, coturn

---

## 📂 Modül README’leri

- [signaling-server.md](./signaling-server.md)
- [web-client.md](./web-client.md)
- [mobile-client.md](./mobile-client.md)
- [coturn-setup.md](./coturn-setup.md)
