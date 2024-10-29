/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package services;

import dao.ConversationDAO;
import dao.MessageDao;
import dao.userDAO;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.stream.Collectors;
import model.Conversation;
import model.Message;
import model.User;
import dtos.ConversationDTO;
import dtos.MessageDTO;
import dtos.UserDTO;
import java.util.ArrayList;

/**
 *
 * @author HELLO
 */
public class ConversationService {

    private ConversationDAO conversationDAO = ConversationDAO.getInstance();

    private userDAO userDaoInterface = userDAO.getInstance();

    private MessageDao messageDaoInterface = MessageDao.getInstance();

    private static ConversationService instance = null;

    private ConversationService() {

    }

    public synchronized static ConversationService getInstance() {
        if (instance == null) {
            instance = new ConversationService();
        }
        return instance;
    }

    private User convertToUserEntity(UserDTO userDTO) {
        User user = new User();
        user.setUser_id(userDTO.getUserId());
        user.setAdmin(userDTO.isIsAdmin());
        return user;
    }

    //Sau này thêm set first last name để hiển thị trong group
    private UserDTO convertToUserDTO(User user) {
        UserDTO userDTO = new UserDTO();
        userDTO.setFirstName(user.getFirst_name());
        userDTO.setLastName(user.getLast_name());
        userDTO.setUserId(user.getUser_id());
        userDTO.setProfile_pic(user.getProfile_pic());
        userDTO.setIsAdmin(user.isAdmin());
        return userDTO;
    }

    private ConversationDTO convertToConversationDTO(Conversation conversation) {
        ConversationDTO conversationDTO = new ConversationDTO();
        conversationDTO.setId(conversation.getId());
        conversationDTO.setName(conversation.getName());
        conversationDTO.setAvatar(conversation.getAvatar().trim());
        return conversationDTO;
    }

    private Conversation convertToConversation(ConversationDTO conversationDTO) {
        Conversation conversation = new Conversation();
        conversation.setId(conversationDTO.getId());
        conversation.setName(conversationDTO.getName());
        if (conversationDTO.getAvatar() != null && !conversationDTO.getAvatar().isEmpty()) {
            conversation.setAvatar(conversationDTO.getAvatar().trim());
        }
        return conversation;
    }

    private MessageDTO convertToMessageDTO(Message messageEntity) {
        int user_id = messageEntity.getSender();
        String type = messageEntity.getType();
        String message = messageEntity.getMessage();
        if (!type.equals("text")) {
            message = FileService.toTagHtml(type, user_id, message);
        }
        int receiver = messageEntity.getReceiver();
        int groupId = messageEntity.getGroupId();
        MessageDTO messageDTO = new MessageDTO(user_id, receiver, message, type, groupId);
        return messageDTO;
    }

    public void saveConversation(ConversationDTO conversationDTO) throws Exception {
        Conversation conversation = convertToConversation(conversationDTO);
        List<User> users = conversationDTO.getUsers().stream().map(userDTO -> convertToUserEntity(userDTO))
                .collect(Collectors.toList());
        conversationDAO.saveConversation(conversation, users);
        conversationDTO.setId(conversation.getId());

//		String dirName = "group-" + conversationDTO.getId();
//		File privateDir = new File(FileService.rootLocation.toString() + "/" + dirName);
//		privateDir.mkdir();
//		String fileName = dirName + ".png";
//		File newFile = new File(privateDir.toString() + "/" + fileName);
//		try {
//			File defaultAvatar = new File(FileService.rootLocation.toString() + "/default/group.png");
//			Files.copy(defaultAvatar.toPath(), newFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
//			conversation.setAvatar(fileName);
//			conversationDAO.saveConversation(conversation, null);
//			conversationDTO.setAvatar(fileName);
//		} catch (IOException ex) {
//		}
    }

    public List<ConversationDTO> getAllConversationsById(int user_id) throws Exception {
        List<Conversation> conversations = conversationDAO.findAllConversationsByUserId(user_id);
        List<ConversationDTO> conversationDTOs = conversations.stream()
                .map(conversation -> convertToConversationDTO(conversation)).collect(Collectors.toList());
        return conversationDTOs;
    }

    public List<UserDTO> getAllUsersByConversationId(int id) throws Exception {
        List<UserDTO> userDTOs = userDaoInterface.findUsersByConversationId(id).stream()
                .map(user -> convertToUserDTO(user)).collect(Collectors.toList());
        return userDTOs;
    }

    public List<MessageDTO> getAllMessagesByConversationId(int id) throws Exception {
        List<MessageDTO> messageDTOs = messageDaoInterface.findAllMessagesByConversationId(id).stream()
                .map(message -> convertToMessageDTO(message)).collect(Collectors.toList());
        return messageDTOs;
    }

    public void updateConversationById(int id, String name, String avatar) throws Exception {
        try {
            Conversation conversation = new Conversation(id, name, avatar);
            conversationDAO.updateConversation(conversation);
        } catch (IOException ex) {
        }
    }

    public ConversationDTO getConversationById(int id) throws Exception {
        Conversation conversation = conversationDAO.findConversationById(id);
        return convertToConversationDTO(conversation);
    }

    public void deleteConversationById(int id) throws Exception {
        conversationDAO.deleteConversationById(id);

    }

    public void deleteUserFromConversation(int conversationId, int user_id) throws Exception {
        conversationDAO.deleteUserFromConversation(conversationId, user_id);
    }

    public List<ConversationDTO> getConversationsOfUserByKeyword(int user_id, String keyword) throws Exception {
        List<ConversationDTO> conversationDTOs = conversationDAO
                .findConversationsOfUserByKeyword(user_id, keyword).stream()
                .map(conversation -> convertToConversationDTO(conversation)).collect(Collectors.toList());
        return conversationDTOs;
    }

    public static void main(String[] args) throws Exception {
//            UserDTO user = new UserDTO();   
//            user.setIsAdmin(true);
//            user.setUserId(2);
//            List<UserDTO> list = new ArrayList<>();
//            list.add(user);
//            ConversationDTO conversationDTO = new ConversationDTO(0, "abc", "abc", list);
//            ConversationService.getInstance().saveConversation(conversationDTO);

//              List<ConversationDTO> c = ConversationService.getInstance().getAllConversationsById(2);
//              for (ConversationDTO ca : c) {
//                  System.out.println(ca.getId());
//              }
//                List<UserDTO> user = ConversationService.getInstance().getAllUsersByConversationId(4);
//                System.out.println(user.size());
//                System.out.println(user.get(0).getUserId());
        List<UserDTO> message = ConversationService.getInstance().getAllUsersByConversationId(1);
        System.out.println(message.get(0).getFirstName());
    }
}
