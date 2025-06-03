# Mobile Client (React Native)

Bu modül, WebRTC ile mobil cihazlarda (Android/iOS) kamera ve mikrofon verisini peer-to-peer olarak ileten uygulamayı kapsar.

## ⚙️ Kullanılan Teknolojiler

- React Native
- react-native-webrtc
- socket.io-client
- react-native-permissions
- react-navigation

## 🚀 Kurulum

```bash
npm install react-native-webrtc socket.io-client react-native-permissions
npx pod-install
npx react-native run-ios # veya run-android
```

## 🔐 Kamera ve Mikrofon İzinleri

### Android

`AndroidManifest.xml` içine ekleyin:

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
```

### iOS

`Info.plist` dosyasına ekleyin:

```xml
<key>NSCameraUsageDescription</key>
<string>Kamera erişimi gereklidir</string>
<key>NSMicrophoneUsageDescription</key>
<string>Mikrofon erişimi gereklidir</string>
```

## 🎥 Medya Erişimi

```js
mediaDevices.getUserMedia({ video: true, audio: true }).then((stream) => {
  setLocalStream(stream);
  peerRef.current.addStream(stream);
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

## 📺 Görüntü Akışı

```js
<RTCView
  streamURL={remoteStream.toURL()}
  style={{ width: "100%", height: 300 }}
/>
```

## 🧪 Test

- Gerçek cihaz + tarayıcı eşlemesi önerilir
- Android + localhost bağlantısı için özel IP gerekebilir

## 📂 Yol Haritası

- [ ] Kamera çevirme butonu
- [ ] Sessize alma/mikrofon kapatma
- [ ] Bağlantı kesilince yeniden bağlan
- [ ] Görüşme süresi sayaç desteği
