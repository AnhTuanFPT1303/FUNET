package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.ArrayList;
import java.sql.SQLException;

import model.Message;
import util.sqlConnect;

public class MessageDao {

    public static MessageDao instance = null;

    public MessageDao() {

    }

    public synchronized static MessageDao getInstance() {
        if (instance == null) {
            instance = new MessageDao();
        }
        return instance;
    }

    public List<Message> findAllMessagesBySenderAndReceiver(int sender, int receiver) throws Exception {
        Connection conn = sqlConnect.getInstance().getConnection();
        String query = "SELECT m1.sender, m1.message_text, m1.message_type, m1.receiver "
                + "FROM message m1 INNER JOIN ( "
                + "    SELECT message_id FROM message "
                + "    WHERE sender = ? OR receiver = ? "
                + ") m2 ON m1.message_id = m2.message_id "
                + "WHERE m1.sender = ? OR m1.receiver = ? "
                + "ORDER BY sent_date ASC";
        PreparedStatement st = conn.prepareStatement(query);
        st.setInt(1, receiver);
        st.setInt(2, receiver);
        st.setInt(3, sender);
        st.setInt(4, sender);
        ResultSet rs = st.executeQuery();
        List<Message> listMessages = new ArrayList<>();
        while (rs.next()) {
            Message msg = new Message(rs.getInt("sender"), rs.getInt("receiver"), rs.getString("message_text"), rs.getString("message_type"));
            listMessages.add(msg);
        }
        return listMessages;
    }

    public List<Message> findAllMessagesByConversationId(int id) throws Exception {
        List<Message> listMessages = new ArrayList<>();

        // Define the SQL query
        String sql = "SELECT m.sender, m.message_text, m.message_type, m.receiver "
                + "FROM message m JOIN userAccount u ON u.user_id = m.sender "
                + "WHERE m.conversation_id = ? "
                + "ORDER BY m.sent_date ASC";
        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();

            // Process the result set
            while (rs.next()) {
                int sender = rs.getInt("sender");
                String messageText = rs.getString("message_text");
                String messageType = rs.getString("message_type");
                int receiver = rs.getInt("receiver");
                Message message = new Message(sender, receiver, messageText, messageType);
                listMessages.add(message);
            }
        } catch (SQLException e) {
            throw new Exception("Error retrieving messages", e);
        }

        return listMessages;
    }

    public Object findAllMessagesByConvesationId(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    
    public void saveMessage(Message message) throws Exception {
        Connection conn = sqlConnect.getInstance().getConnection();
        int sender = message.getSender();
        int receiver = message.getReceiver();
        String msg = message.getMessage();
        String type = message.getType();
        int conversations_id = message.getGroupId();
        PreparedStatement stmt = null;

        // If it's a one-to-one message (sender and receiver)
        if (receiver != 0) {
            String query = "INSERT INTO message(sender, receiver, message_text, message_type) VALUES(?,?,?,?)";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, sender);        
            stmt.setInt(2, receiver);     
            stmt.setString(3, msg);        
            stmt.setString(4, type);      
        } // If it's a group message (sender and group)
        else {
            String query = "INSERT INTO message(sender, conversation_id, message_text, message_type) VALUES(?,?,?,?)";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, sender);       
            stmt.setInt(2, conversations_id);         
            stmt.setString(3, msg);        
            stmt.setString(4, type); 
        }

        // Execute the insert statement
        stmt.executeUpdate();

        // Close resources
        stmt.close();
    }
    public static void main(String[] args) throws Exception {
        List<Message> msg = MessageDao.getInstance().findAllMessagesBySenderAndReceiver(1, 2);
        System.out.println(msg.get(1).getMessage());
    }
}
