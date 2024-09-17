package dao;

import util.sqlConnect;
import java.sql.*;
import model.User;
import java.util.ArrayList;

public class userDAO {

    public boolean login(String email, String password) {
        boolean result = false;
        try {
            Connection conn = sqlConnect.getInstance().getConnection();
            PreparedStatement st = conn.prepareStatement("Select * from userAccount where email=? AND password=?");
            st.setString(1, email);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                result = true;
            }
        } catch (Exception e) {
            System.out.println("Connect Failed");
        }
        return result;
    }

    public String register(User user) {
        try {
            Connection conn = sqlConnect.getInstance().getConnection();
            CallableStatement st = conn.prepareCall("INSERT INTO userAccount Values (?,?,?,?,?)"); //Call register procedure in SQL Server
            st.setString(1, user.getFirst_name());
            st.setString(2, user.getLast_name());
            st.setString(3, user.getPassword());
            st.setString(4, user.getEmail());
            st.setString(5, user.getProfile_pic());
            st.execute();
            return "Registration Successful.";
        } catch (SQLException e) {
            return "Duplicate Email.";
        } catch (Exception e) {
            return "Unknown Exception";
        }
    }

    public User getUserByEmail(String email) throws SQLException {
        User u = new User();
        try {
            Connection conn = sqlConnect.getInstance().getConnection();
            PreparedStatement st = conn.prepareStatement("SELECT * FROM userAccount WHERE email = ?");
            st.setString(1, email);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                u.setUser_id(rs.getInt(1));
                u.setFirst_name(rs.getString(2));
                u.setLast_name(rs.getString(3));
                u.setPassword(rs.getString(4));
                u.setEmail(rs.getString(5));
                u.setProfile_pic(rs.getString(6));
            }

        } catch (Exception e) {
            System.out.println("Action Failed");
        }
        return u;
    }

    public User getUserById(int user_id) throws SQLException {
        User u = new User();
        try {
            Connection conn = sqlConnect.getInstance().getConnection();
            PreparedStatement st = conn.prepareStatement("SELECT * FROM userAccount WHERE user_id = ?");
            st.setInt(1, user_id);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                u.setUser_id(rs.getInt(1));
                u.setFirst_name(rs.getString(2));
                u.setLast_name(rs.getString(3));
                u.setPassword(rs.getString(4));
                u.setEmail(rs.getString(5));
                u.setProfile_pic(rs.getString(6));
            }

        } catch (Exception e) {
            System.out.println("Action Failed");
        }
        return u;
    }

    public static ArrayList<User> getAllUserByName(String name, int current_userId) throws SQLException {
        ArrayList<User> userList = new ArrayList<>();
        try {
            Connection conn = sqlConnect.getInstance().getConnection();
            PreparedStatement st = conn.prepareStatement("SELECT user_id, first_name, last_name, profile_pic FROM userAccount WHERE (first_name LIKE ? OR last_name LIKE ?) AND NOT user_id = ? ");
            st.setString(1, "%" + name + "%");
            st.setString(2, "%" + name + "%");
            st.setInt(3, current_userId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setUser_id(rs.getInt(1));
                u.setFirst_name(rs.getString(2));
                u.setLast_name(rs.getString(3));
                u.setProfile_pic(rs.getString(4));
                userList.add(u);
            }

        } catch (Exception e) {
            System.out.println("Action Failed");
        }
        return userList;
    }

    public boolean checkEmail(String email) {
        boolean exists = false;
        try {
            Connection conn = sqlConnect.getInstance().getConnection();
            PreparedStatement st = conn.prepareStatement("SELECT 1 FROM userAccount WHERE email = ?");
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                exists = true;
            }
        } catch (SQLException e) {
            System.out.println("SQL Exception occurred while checking email.");
        } catch (Exception e) {
            System.out.println("An unknown error occurred while checking email.");
        }
        return exists;
    }

    public void updateUser(User user) {
        String query = "UPDATE userAccount SET first_name =?, last_name =?, password =? WHERE user_id =?";
        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, user.getFirst_name());
            stmt.setString(2, user.getLast_name());
            stmt.setString(3, user.getPassword());
            stmt.setInt(4, user.getUser_id());
            stmt.executeUpdate();
        } catch (Exception e) {
            // log the error and exception
            e.printStackTrace();
        }
    }
    
    public ArrayList<User> getAllUsers() throws Exception {
        ArrayList<User> users = new ArrayList<>();
        try {
            Connection conn = sqlConnect.getInstance().getConnection();
            PreparedStatement st = conn.prepareStatement("SELECT * FROM userAccount");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setUser_id(rs.getInt("user_id"));
                u.setFirst_name(rs.getString("first_name"));
                u.setLast_name(rs.getString("last_name"));
                u.setEmail(rs.getString("email"));
                u.setProfile_pic(rs.getString("profile_pic"));
                users.add(u);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching all users: " + e.getMessage());
        }
        return users;
    }

    public ArrayList<User> getUserFriends(int userId) throws Exception {
        ArrayList<User> friends = new ArrayList<>();
        try {
            Connection conn = sqlConnect.getInstance().getConnection();
            PreparedStatement st = conn.prepareStatement(
                    "SELECT u.user_id, u.first_name, u.last_name, u.email, u.profile_pic "
                    + "FROM userAccount u "
                    + "INNER JOIN friendship f ON (u.user_id = f.user_request OR u.user_id = f.user_accept) "
                    + "WHERE ((f.user_request = ? OR f.user_accept = ?) AND u.user_id != ? AND f.status = 'accepted')"
            );
            st.setInt(1, userId);
            st.setInt(2, userId);
            st.setInt(3, userId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setUser_id(rs.getInt("user_id"));
                u.setFirst_name(rs.getString("first_name"));
                u.setLast_name(rs.getString("last_name"));
                u.setEmail(rs.getString("email"));
                u.setProfile_pic(rs.getString("profile_pic"));
                friends.add(u);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching user friends: " + e.getMessage());
        }
        return friends;
    }
    
    public void changeAvatar(User u){
        String query = "UPDATE userAccount SET profile_pic =? WHERE user_id =?";
        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, u.getProfile_pic());
            stmt.setInt(2, u.getUser_id());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
