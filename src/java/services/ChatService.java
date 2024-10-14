package services;

import dao.userDAO;
import jakarta.websocket.EncodeException;
import java.io.IOException;
import java.util.Set;
import java.util.HashSet;
import java.util.List;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.stream.Collectors;
import websockets.ChatWebsocket;
import model.User;
import dtos.MessageDTO;

public class ChatService {

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

    public void sendMessageToOneUser(MessageDTO message) throws Exception {
        if (message.getReceiver() != 0) {
            // Send message to a single user
            chatWebsockets.stream()
                    .filter(chatWebsocket -> chatWebsocket.getUserId() == message.getReceiver())
                    .forEach(chatWebsocket -> {
                        try {
                            chatWebsocket.getSession().getBasicRemote().sendObject(message);
                        } catch (IOException | EncodeException e) {
                            e.printStackTrace();
                        }
                    });
        } else {
            // Send message to a group of users
            List<User> usersGroup = userDao.findUsersByConversationId(message.getGroupId());

            // Collect all user IDs in the group
            List<Integer> userIdGroup = usersGroup.stream()
                    .map(User::getUser_id)
                    .collect(Collectors.toList());

            // Send the message to all users in the group, excluding the sender
            chatWebsockets.stream()
                    .filter(chatWebsocket -> userIdGroup.contains(chatWebsocket.getUserId())
                    && chatWebsocket.getUserId() != message.getSender()) // Filter out the sender
                    .forEach(chatWebsocket -> {
                        try {
                            chatWebsocket.getSession().getBasicRemote().sendObject(message);
                        } catch (IOException | EncodeException e) {
                            System.err.println("Error sending message to user: " + chatWebsocket.getUserId());
                            e.printStackTrace();
                        }
                    });
        }
    }

    protected Set<Integer> getIdList() {
        Set<Integer> id_list = new HashSet<>();
        chatWebsockets.forEach(chatWebsocket -> {
            id_list.add(chatWebsocket.getUserId());
        });
        return id_list;
    }
}
