package services;

import jakarta.websocket.EncodeException;
import java.io.IOException;
import java.util.Set;
import java.util.HashSet;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.logging.Level;
import java.util.logging.Logger;
import websockets.ChatWebsocket;
import model.Message;
import websockets.MessageEncoder;

public class ChatService {

    private static ChatService chatService = null;
    protected static final Set<ChatWebsocket> chatWebsockets = new CopyOnWriteArraySet<>();

    private ChatService() {
    }

    public synchronized static ChatService getInstance() {
        if (chatService == null) {
            chatService = new ChatService();
        }
        return chatService;
    }

    public boolean register(ChatWebsocket chatWebsocket) {
        return chatWebsockets.add(chatWebsocket);
    }

    public boolean close(ChatWebsocket chatWebsocket) {
        return chatWebsockets.remove(chatWebsocket);
    }

    public void sendMessageToOneUser(Message message) {
        if (message == null) {
            throw new IllegalArgumentException("Message cannot be null");
        }
        // Broadcast the message to both the receiver and the sender
        chatWebsockets.stream()
                .filter(chatWebsocket -> chatWebsocket.getUserId() == message.getReceiver())
                .forEach(chatWebsocket -> {
                    try {
                        if (chatWebsocket.getSession().isOpen()) {
                            MessageEncoder messageEncoder = new MessageEncoder();
                            chatWebsocket.getSession().getBasicRemote().sendText(messageEncoder.encode(message));
                        } else {
                            System.err.println("WebSocket session is closed for user: " + chatWebsocket.getUserId());
                        }
                    } catch (IOException | EncodeException e) {
                        e.printStackTrace();
                    }
                });
    }

    protected Set<Integer> getIdList() {
        Set<Integer> id_list = new HashSet<>();
        chatWebsockets.forEach(chatWebsocket -> {
            id_list.add(chatWebsocket.getUserId());
        });
        return id_list;
    }
}
