package websockets;

import jakarta.websocket.DecodeException;
import jakarta.websocket.Decoder;
import jakarta.websocket.EndpointConfig;
import model.Message;
import org.json.JSONObject;

public class MessageDecoder implements Decoder.Text<Message> {
    
    @Override
    public Message decode(String s) throws DecodeException {
        JSONObject jsonObject = new JSONObject(s);
        int fromUser = jsonObject.getInt("fromUser");
        int toUser = jsonObject.getInt("toUser");
        String content = jsonObject.getString("content");
        return new Message(fromUser, toUser, content);
    }

    @Override
    public boolean willDecode(String s) {
        try {
            JSONObject jsonObject = new JSONObject(s); // Attempt to create a JSONObject
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public void init(EndpointConfig ec) {
        // Initialization logic, if needed
    }

    @Override
    public void destroy() {
        // Cleanup logic, if needed
    }
}
