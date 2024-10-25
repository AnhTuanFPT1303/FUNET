package services;

import com.cloudinary.utils.ObjectUtils;
import dao.userDAO;
import dtos.FileDTO;
import jakarta.websocket.EncodeException;
import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.stream.Collectors;
import websockets.ChatWebsocket;
import model.User;
import dtos.MessageDTO;
import java.io.File;
import java.nio.ByteBuffer;
import java.util.Map;
import java.util.Queue;
import java.util.Set;
import java.util.logging.Logger;
import util.CloudinaryAPI;

public class ChatService {

    private static final Logger LOGGER = Logger.getLogger(ChatService.class.getName());
    private userDAO userDao = userDAO.getInstance();
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

    public boolean isUserOnline(int user_id) {
        for (ChatWebsocket chatWebsocket : chatWebsockets) {
            if (chatWebsocket.getUserId() == user_id) {
                return true;
            }
        }
        return false;
    }

    public void sendMessageToAllUsers(MessageDTO message) {
        message.setOnlineList(getIdList());
        chatWebsockets.stream().forEach(chatWebsocket -> {
            try {
                chatWebsocket.getSession().getBasicRemote().sendObject(message);
            } catch (IOException | EncodeException e) {
                e.printStackTrace();
            }
        });
    }

    public void sendMessageToOneUser(MessageDTO message, Queue<FileDTO> fileDTOs) throws Exception {
        // Send message to a single user
        if (!message.getType().equals("text")) {
            String url = message.getMessage();
            String typeFile = message.getType();
            if (typeFile.startsWith("audio")) {
                message.setMessage("<audio controls>\r\n" + "  <source src=\"" + url + "\" type=\""
                        + typeFile + "\">\r\n" + "</audio>");
            } else if (typeFile.startsWith("video")) {
                message.setMessage("<video width=\"400\" controls>\r\n" + "  <source src=\"" + url
                        + "\" type=\"" + typeFile + "\">\r\n" + "</video>");
            } else if (typeFile.startsWith("image")) {
                message.setMessage("<img src=\"" + url + "\" alt=\"\">");
            }
        }
        chatWebsockets.stream()
                .filter(chatWebsocket -> chatWebsocket.getUserId() == message.getReceiver())
                .forEach(chatWebsocket -> {
                    try {
                        chatWebsocket.getSession().getBasicRemote().sendObject(message);
                    } catch (IOException | EncodeException e) {
                        e.printStackTrace();
                    }
                });
    }

    public void sendMessageToGroup(MessageDTO message, Queue<FileDTO> fileDTOs) throws Exception {
        List<User> usersGroup = userDao.findUsersByConversationId(message.getGroupId());
        Set<Integer> userIdGroup = usersGroup.stream().map(User::getUser_id).collect(Collectors.toSet());
        chatWebsockets.stream()
                .filter(chatWebsocket -> userIdGroup.contains(chatWebsocket.getUserId())
                && chatWebsocket.getUserId() != message.getSender())
                .forEach(chatWebsocket -> {
                    try {
                        chatWebsocket.getSession().getBasicRemote().sendObject(message);
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
