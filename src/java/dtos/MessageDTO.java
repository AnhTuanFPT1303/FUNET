package dtos;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.HashSet;
import java.util.Set;

public class MessageDTO {

    @JsonProperty("sender")
    private int sender;

    @JsonProperty("receiver")
    private int receiver;

    @JsonProperty("message")
    private String message;

    @JsonProperty("type")
    private String type;

    @JsonProperty("groupId")
    private int groupId;

    @JsonProperty("onlineList")
    private Set<Integer> onlineList = new HashSet<Integer>();

    public MessageDTO() {
    }

    @JsonCreator
    public MessageDTO(
            @JsonProperty("sender") int sender,
            @JsonProperty("receiver") int receiver,
            @JsonProperty("message") String message,
            @JsonProperty("type") String type,
            @JsonProperty("groupId") int groupId) {

        this.sender = sender;
        this.receiver = receiver;
        this.message = message;
        this.type = type;
        this.groupId = groupId;
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

    public Set<Integer> getOnlineList() {
        return onlineList;
    }

    public void setOnlineList(Set<Integer> onlineList) {
        this.onlineList = onlineList;
    }
}
