package websockets;

import jakarta.websocket.EncodeException;
import jakarta.websocket.Encoder;
import jakarta.websocket.EndpointConfig;
import model.Message;
import org.json.JSONObject;

public class MessageEncoder implements Encoder.Text<Message> {

    @Override
    public String encode(Message message) throws EncodeException {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("sender", message.getSender());
        jsonObject.put("receiver", message.getReceiver());
        jsonObject.put("message", message.getMessage());
        jsonObject.put("type", message.getType());
        jsonObject.put("groupId", message.getGroupId());
        return jsonObject.toString();
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
