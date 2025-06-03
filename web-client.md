# Web Client (React)

Bu modül, tarayıcı tarafında WebRTC görüntülü görüşme altyapısını kurar. Mobil istemci ile eşleşip medya akışı sağlar.

## ⚙️ Kullanılan Teknolojiler

- React (Vite önerilir)
- simple-peer
- socket.io-client
- WebRTC API

## 🚀 Kurulum

```bash
npm install
npm install simple-peer socket.io-client
npm run dev
```

## 📦 Bağlantı Yapısı

```js
const peer = new SimplePeer({
  initiator: true,
  trickle: false,
  stream: localMediaStream,
  config: {
    iceServers: [
      { urls: "stun:stun.l.google.com:19302" },
      {
        urls: "turns:yourdomain.com:5349",
        username: "user",
        credential: "token",
      },
    ],
  },
});
```

## 🔌 Signaling

```js
const socket = io("https://your-signaling-server.com");

peer.on("signal", (data) => {
  socket.emit("signal", { target: remoteId, data });
});

socket.on("signal", ({ data }) => {
  peer.signal(data);
});
```

## 🎥 Medya Erişimi

```js
navigator.mediaDevices
  .getUserMedia({ video: true, audio: true })
  .then((stream) => {
    setLocalStream(stream);
    peer.addStream(stream);
  });
```

## 📺 UI Notları

- Bağlantı kurulduğunda uzaktaki video elementine stream bağlanmalı
- `peer.on('stream', remoteStream => { ... })` ile yapılır

## 🧪 Test

- Chrome + mobil emulator ile eşleştirme yapılabilir
- Trickle ICE ile bağlantı türleri test edilebilir

## 📂 Yol Haritası

- [ ] ICE bağlantı durumu gösterimi
- [ ] Mikrofon/kamera toggle
- [ ] Bağlantı koptu ekranı
- [ ] Görüşme süresi göstergesi
