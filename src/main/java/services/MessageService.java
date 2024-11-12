/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package services;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import controller.postServlet;
import dao.MessageDao;
import java.util.ArrayList;
import java.util.List;
import model.Message;
import dtos.MessageDTO;
import jakarta.servlet.ServletException;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.CloudinaryAPI;

/**
 *
 * @author HELLO
 */
public class MessageService {

    private static MessageService instance = null;

    private MessageDao messageDAO = MessageDao.getInstance();

    private Cloudinary cloud;

    public static MessageService getInstance() {
        if (instance == null) {
            instance = new MessageService();
        }
        return instance;
    }

    private Message convertToEntity(MessageDTO messageDTO) {
        int user_id = messageDTO.getSender();
        String message = messageDTO.getMessage();
        String type = messageDTO.getType();
        int receiver = messageDTO.getReceiver();
        int groupId = messageDTO.getGroupId();
        Message messageEntity = new Message(user_id, receiver, message, type, groupId);
        return messageEntity;
    }

    private MessageDTO convertToDTO(Message messageEntity) {
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

    public List<MessageDTO> getAllMessagesBySenderAndReceiver(int sender, int receiver) throws Exception {
        List<Message> listMessages = messageDAO.findAllMessagesBySenderAndReceiver(sender, receiver);
        List<MessageDTO> listMessageDTOs = new ArrayList<>();
        listMessages.stream().forEach(msg -> {
            MessageDTO messageDTO = convertToDTO(msg);
            listMessageDTOs.add(messageDTO);
        });
        return listMessageDTOs;
    }

    public void saveMessage(MessageDTO messageDTO) {
        try {
            Message messageEntity = convertToEntity(messageDTO);
            System.out.println("url of message is: " + messageEntity.getMessage());
            messageDAO.saveMessage(messageEntity);
        } catch (Exception ex) {
            System.out.println("Err here");
        }
    }

    public static void main(String[] args) throws Exception {
        List<MessageDTO> list = MessageService.getInstance().getAllMessagesBySenderAndReceiver(1, 2);
        System.out.println(list.get(list.size()-1).getMessage());
    }
}
