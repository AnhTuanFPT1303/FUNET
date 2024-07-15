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
        PreparedStatement st = conn.prepareStatement("select m1.from_user, m1.message, m1.to_user from message m1 inner join(select chat_id from message where from_user = ? or to_user = ? ) m2 on m1.chat_id = m2.chat_id where m1.from_user = ? or m1.to_user = ? order by chat_time asc");
        st.setInt(1, sender);
        st.setInt(2, sender);
        st.setInt(3, receiver);
        st.setInt(4, receiver);
        ResultSet rs = st.executeQuery();
        List<Message> listMessages = new ArrayList<>();
        while (rs.next()) {
            Message msg = new Message(sender, receiver, rs.getString(2));
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
