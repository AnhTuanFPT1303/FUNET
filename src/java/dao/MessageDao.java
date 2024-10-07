package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.ArrayList;

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

    public void saveMessage(Message message) throws Exception {
        int sender = message.getSender();
        int receiver = message.getReceiver();
        String msg = message.getMessage();
        Connection conn = sqlConnect.getInstance().getConnection();
        PreparedStatement st = conn.prepareStatement("insert into message values(?,?,NULL,?,?,CURRENT_TIMESTAMP)");
        st.setInt(1, sender);
        st.setInt(2, receiver);
        st.setString(3, msg);
        st.setString(4, "text");
        st.executeUpdate();
    }

    public static void main(String[] args) throws Exception {
        List<Message> msg = MessageDao.getInstance().findAllMessagesBySenderAndReceiver(1, 2);
        System.out.println(msg.get(0).getMessage());
    }
}
