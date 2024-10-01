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
        String query = "SELECT sender, message, receiver FROM message "
                + "WHERE (sender = ? AND receiver = ?) "
                + "OR (sender = ? AND receiver = ?) "
                + "ORDER BY chat_time ASC";
        PreparedStatement st = conn.prepareStatement(query);
        st.setInt(1, sender);
        st.setInt(2, receiver);
        st.setInt(3, receiver);
        st.setInt(4, sender);
        ResultSet rs = st.executeQuery();
        List<Message> listMessages = new ArrayList<>();
        while (rs.next()) {
            Message msg = new Message(rs.getInt("sender"), rs.getInt("receiver"), rs.getString("message"));
            listMessages.add(msg);
        }
        return listMessages;
    }

    public void saveMessage(Message message) throws Exception {
        int sender = message.getFromUser();
        int receiver = message.getToUser();
        String msg = message.getMessage();
        Connection conn = sqlConnect.getInstance().getConnection();
        PreparedStatement st = conn.prepareStatement("insert into message values(?,?,?,CURRENT_TIMESTAMP)");
        st.setInt(1, sender);
        st.setInt(2, receiver);
        st.setString(3, msg);
        st.executeUpdate();
    }
}
