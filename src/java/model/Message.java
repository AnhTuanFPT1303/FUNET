package model;

public class Message {

    private int sender;
    private int receiver;
    private String message;
    private String type;
    private int groupId;

    public Message(int sender, int receiver, String message, String type) {
        this.sender = sender;
        this.receiver = receiver;
        this.message = message;
        this.type = type;
    }

    public Message(int sender, int receiver, String message, String type, int groupId) {
        this.sender = sender;
        this.receiver = receiver;
        this.message = message;
        this.type = type;
        this.groupId = groupId;

    }

    public Message() {
    }

    public Message(int sender, int receiver, String messageText) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public int getSender() {
        return sender;
    }

    public void setSender(int sender) {
        this.sender = sender;
    }

    public int getReceiver() {
        return receiver;
    }

    public void setReceiver(int receiver) {
        this.receiver = receiver;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }
}
