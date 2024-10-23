/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package dao;

import java.util.List;
import model.Conversation;
import model.User;
import util.sqlConnect;
import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author HELLO
 */
public class ConversationDAO {

    /**
     * @param args the command line arguments
     */
    private static ConversationDAO instance = null;

    private ConversationDAO() {

    }

    public synchronized static ConversationDAO getInstance() {
        if (instance == null) {
            instance = new ConversationDAO();
        }
        return instance;
    }

        public void saveConversation(Conversation conversation, List<User> users) throws Exception {
        if (users == null) {
            return;
        } else {
            Connection conn = sqlConnect.getInstance().getConnection();
            try {
                if (conversation.getId() == 0) {
                    createNewConversation(conn, conversation, users);
                } else {
                    for (User user : users) {
                        addUserToConversation(conn, conversation.getId(), user);
                    }
                }
            } finally {
            }
        }
    }
        
    private void createNewConversation(Connection conn, Conversation conversation, List<User> users) throws Exception {
//      CONCAT('group-', CAST(IDENT_CURRENT('conversation') AS CHAR(50)))
        String createConversationSQL = "INSERT INTO conversation(conversation_name, conversation_avatar) VALUES(?, ?)";
        PreparedStatement st = conn.prepareStatement(createConversationSQL, PreparedStatement.RETURN_GENERATED_KEYS);
        st.setString(1, conversation.getName());
        st.setString(2, "group2.jpg");
        st.executeUpdate();
        ResultSet rs = st.getGeneratedKeys();
        if (rs.next()) {
            conversation.setId(rs.getInt(1));  // Setting the generated conversation_id
        }

        if (users != null) {
            for (User user : users) {
                addUserToConversation(conn, conversation.getId(), user);
            }
        }
    }

    private void addUserToConversation(Connection conn, int conversationId, User user) throws Exception {
        String addUserSQL = "INSERT INTO conversation_users(conversation_id, user_id, is_admin) VALUES(?, ?, ?)";
        PreparedStatement st = conn.prepareStatement(addUserSQL);
        st.setInt(1, conversationId);
        st.setInt(2, user.getUser_id());
        st.setBoolean(3, user.isAdmin());
        st.executeUpdate();
    }

    private void updateConversation(Connection conn, Conversation conversation) throws Exception {
        String updateSQL = "UPDATE conversation SET conversation_name=?, conversation_avatar=? WHERE conversation_id=?";
        PreparedStatement st = conn.prepareStatement(updateSQL);
        st.setString(1, conversation.getName());
        st.setString(2, conversation.getAvatar().replaceAll(" ", ""));
        st.setInt(3, conversation.getId());
        st.executeUpdate();
    }

    public List<Conversation> findAllConversationsByUserId(int userId) throws Exception {
        Connection conn = sqlConnect.getInstance().getConnection();
        String query = "SELECT c.conversation_id, c.conversation_name, c.conversation_avatar "
                + "FROM conversation c JOIN conversation_users cu ON c.conversation_id = cu.conversation_id "
                + "WHERE cu.user_id = ?";
        PreparedStatement st = conn.prepareStatement(query);
        st.setInt(1, userId);
        ResultSet rs = st.executeQuery();
        List<Conversation> conversations = new ArrayList<>();
        while (rs.next()) {
            Conversation conversation = new Conversation(rs.getInt("conversation_id"), rs.getString("conversation_name"), rs.getString("conversation_avatar"));
            conversations.add(conversation);
        }
        return conversations;
    }

    public Conversation findConversationById(int id) throws Exception {
        Connection conn = sqlConnect.getInstance().getConnection();
        String query = "SELECT c.conversation_id, c.conversation_name, c.conversation_avatar FROM conversation c WHERE c.conversation_id = ?";
        PreparedStatement st = conn.prepareStatement(query);
        st.setInt(1, id);
        ResultSet rs = st.executeQuery();
        Conversation conversation = null;
        if (rs.next()) {
            conversation = new Conversation(rs.getInt("conversation_id"), rs.getString("conversation_name"), rs.getString("conversation_avatar"));
        }
        return conversation;
    }

    public void deleteConversationById(int id) throws Exception {
        Connection conn = sqlConnect.getInstance().getConnection();
        try {
            String deleteSQL = "DELETE FROM conversation_users WHERE conversation_id = ?;"
                    + "DELETE FROM message WHERE conversation_id = ?;"
                    + "DELETE FROM conversation WHERE conversation_id = ?";
            PreparedStatement st = conn.prepareStatement(deleteSQL);
            st.setInt(1, id);
            st.setInt(2, id);
            st.setInt(3, id);
            st.executeUpdate();
        } finally {
        }
    }

    public void deleteUserFromConversation(int conversationId, int userId) throws Exception {
        Connection conn = sqlConnect.getInstance().getConnection();
        String deleteSQL = "DELETE FROM conversation_users WHERE conversation_id = ? AND user_id = ?";
        PreparedStatement st = conn.prepareStatement(deleteSQL);
        st.setInt(1, conversationId);
        st.setInt(2, userId);
        st.executeUpdate();
    }

    public List<Conversation> findConversationsOfUserByKeyword(int userId, String keyword) throws Exception {
        Connection conn = sqlConnect.getInstance().getConnection();
        String query = "SELECT c.conversation_id, c.conversation_name, c.conversation_avatar "
                + "FROM conversation c JOIN conversation_users cu ON cu.conversation_id = c.conversation_id "
                + "WHERE c.conversation_name LIKE ? AND cu.user_id = ?";
        PreparedStatement st = conn.prepareStatement(query);
        st.setString(1, "%" + keyword + "%");
        st.setInt(2, userId);
        ResultSet rs = st.executeQuery();
        List<Conversation> conversations = new ArrayList<>();
        while (rs.next()) {
            Conversation conversation = new Conversation(rs.getInt("conversation_id"), rs.getString("conversation_name"), rs.getString("conversation_avatar"));
            conversations.add(conversation);
        }
        return conversations;
    }

    public static void main(String[] args) throws Exception {
        List<Conversation> list = ConversationDAO.getInstance().findAllConversationsByUserId(1);
        for (Conversation conversation : list) {
            System.out.println(conversation.getId());
        }
    }
}
