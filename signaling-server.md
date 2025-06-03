# Signaling Server (Spring Boot + WebSocket)

Bu modül, WebRTC eşleşmeleri için signaling görevini gören bir Spring Boot WebSocket sunucusudur. HTTP session ile entegre çalışır.

## 🧱 Kullanılan Teknolojiler

- Spring Boot (WebSocket)
- Java 17+
- Session tabanlı authentication (Spring Security)
- Jackson (JSON parsing)

## 📦 Maven Bağımlılıkları

```xml
<dependencies>
  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-websocket</artifactId>
  </dependency>
  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
  </dependency>
  <dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-databind</artifactId>
  </dependency>
</dependencies>
```

## 🔌 WebSocket Yapılandırması

### WebSocketConfig.java

```java
@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(new SignalingHandler(), "/signal")
                .addInterceptors(new HttpSessionHandshakeInterceptor())
                .setAllowedOrigins("*");
    }
}
```

## 📡 Signaling Handler

### SignalingHandler.java

```java
public class SignalingHandler extends TextWebSocketHandler {

    private final Map<String, WebSocketSession> sessions = new ConcurrentHashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        Authentication auth = (Authentication) session.getAttributes().get("SPRING_SECURITY_CONTEXT");
        if (auth != null) {
            sessions.put(auth.getName(), session);
        }
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        SignalMessage data = new ObjectMapper().readValue(message.getPayload(), SignalMessage.class);
        WebSocketSession target = sessions.get(data.getTarget());
        if (target != null && target.isOpen()) {
            target.sendMessage(message);
        }
    }
}
```

## ✉️ Mesaj Modeli

### SignalMessage.java

```java
@Data
public class SignalMessage {
    private String type;    // offer, answer, candidate
    private String sender;
    private String target;
    private String data;
}
```

## 🔐 Güvenlik

- WebSocket bağlantısı öncesi HTTP login yapılmalı
- HttpSessionHandshakeInterceptor ile kullanıcı oturumu alınır

## 🧪 Test

- WebSocket endpoint: ws://localhost:8080/signal
- Tarayıcı test: Smart WebSocket Client veya Postman WebSocket

## 📂 Yol Haritası

- [ ] JWT destekli auth
- [ ] Bağlantı loglama
- [ ] Disconnect olaylarını izleme
