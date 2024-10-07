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
        int sender = jsonObject.getInt("sender");
        int receiver = jsonObject.getInt("receiver");
        String message = jsonObject.getString("message");
        String type = jsonObject.getString("type");
        int groupId = jsonObject.getInt("groupId");
        return new Message(sender, receiver, message, type, groupId);
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
