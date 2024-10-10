package websockets;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.websocket.DecodeException;
import jakarta.websocket.Decoder;
import jakarta.websocket.EndpointConfig;
import java.io.IOException;
import dtos.MessageDTO;
import org.json.JSONObject;

public class MessageDecoder implements Decoder.Text<MessageDTO> {

    private ObjectMapper objectMapper = new ObjectMapper();
    
    @Override
    public MessageDTO decode(final String arg0) throws DecodeException {
        try {
            return objectMapper.readValue(arg0, MessageDTO.class);
        } catch (IOException e) {
            throw new DecodeException(arg0, "Unable to decode text to Message", e);
        }
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
