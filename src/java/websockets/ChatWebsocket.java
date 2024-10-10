package websockets;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;
import model.Message;
import services.ChatService;
import dao.MessageDao;
import jakarta.websocket.DecodeException;

@ServerEndpoint(value = "/chat/{user_id}")
public class ChatWebsocket {

    private Session session;
    private int user_id;

    ChatService chatService = ChatService.getInstance();
    MessageDao messageDao = MessageDao.getInstance();
    MessageDecoder messageDecoder = new MessageDecoder();

    @OnOpen
    public void onOpen(@PathParam("user_id") int user_id, Session session) {
        this.user_id = user_id;
        this.session = session;
        chatService.register(this);
    }

    @OnMessage
    public void onMessage(String messageJson, Session session) throws DecodeException, Exception {
        Message message = messageDecoder.decode(messageJson);
        chatService.sendMessageToOneUser(message);
    }

    @OnClose
    public void onClose(Session session) {
        chatService.close(this);
    }

    public Session getSession() {
        return session;
    }

    public int getUserId() {
        return user_id;
    }
}
