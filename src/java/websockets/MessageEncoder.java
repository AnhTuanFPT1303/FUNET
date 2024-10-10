package websockets;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.websocket.EncodeException;
import jakarta.websocket.Encoder;
import jakarta.websocket.EndpointConfig;
import model.dtos.MessageDTO;

public class MessageEncoder implements Encoder.Text<MessageDTO> {

    private ObjectMapper objectMapper = new ObjectMapper();
    
    @Override
    public String encode(MessageDTO message) throws EncodeException {
        try {
            return objectMapper.writeValueAsString(message);
        } catch (JsonProcessingException e) {
            throw new EncodeException(message, "Unable to encode message", e);
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
