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
        jsonObject.put("fromUser", message.getFromUser());
        jsonObject.put("toUser", message.getToUser());
        jsonObject.put("message", message.getMessage());
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
