package websockets;

import com.cloudinary.utils.ObjectUtils;
import dtos.FileDTO;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;
import services.ChatService;
import jakarta.websocket.DecodeException;
import dtos.MessageDTO;
import java.io.File;
import java.nio.ByteBuffer;
import java.util.LinkedList;
import java.util.Map;
import java.util.Queue;
import services.MessageService;
import java.util.logging.Logger;
import util.CloudinaryAPI;

@ServerEndpoint(value = "/chat/{user_id}", encoders = MessageEncoder.class, decoders = MessageDecoder.class)
public class ChatWebsocket {

    private static final Logger LOGGER = Logger.getLogger(ChatWebsocket.class.getName());
    private Session session;
    private int user_id;
    private Queue<FileDTO> fileDTOs = new LinkedList<>();

    ChatService chatService = ChatService.getInstance();
    MessageService messageService = MessageService.getInstance();

    @OnOpen
    public void onOpen(@PathParam("user_id") int user_id, Session session) {
        if (chatService.register(this)) {
            this.user_id = user_id;
            this.session = session;
        }

    }

    @OnMessage
    public void onMessage(MessageDTO message, Session session) throws DecodeException, Exception {
        if (message.getReceiver() != 0) {
            chatService.sendMessageToOneUser(message, fileDTOs);
        } else {
            message.setReceiver(0);
            chatService.sendMessageToGroup(message, fileDTOs);
        }
        messageService.saveMessage(message);
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
