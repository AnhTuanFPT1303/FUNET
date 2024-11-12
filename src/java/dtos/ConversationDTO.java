package dtos;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class ConversationDTO {

    @JsonProperty("id")
    private int id; // Changed from Long to int

    @JsonProperty("name")
    private String name;

    @JsonProperty("avatar")
    private String avatar;

    @JsonProperty("users")
    private List<UserDTO> users;

    public ConversationDTO() {
    }

    @JsonCreator
    public ConversationDTO(@JsonProperty("id") int id,
            @JsonProperty("name") String name,
            @JsonProperty("avatar") String avatar,
            @JsonProperty("users") List<UserDTO> users) {
        this.id = id;
        this.name = name;
        this.avatar = avatar;
        this.users = users;
    }

    public int getId() {
        return id; // Changed from Long to int
    }

    public void setId(int id) { // Changed from Long to int
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public List<UserDTO> getUsers() {
        return users;
    }

    public void setUsers(List<UserDTO> users) {
        this.users = users;
    }
}
