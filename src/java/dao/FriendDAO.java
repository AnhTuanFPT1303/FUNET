/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import util.sqlConnect;
import java.sql.*;
import java.util.ArrayList;
import model.User;

/**
 *
 * @author HELLO
 */
public class FriendDAO {

    public int friendCount(int userId) throws Exception {
        int friendNum = 0;
        String query = "SELECT COUNT(*) AS friend_count FROM friendship WHERE (sender = ? OR receiver = ?) AND status = 'accepted'";
        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    friendNum = rs.getInt("friend_count");
                }
            }
        } catch (SQLException e) {
            System.out.println("An error occurred while counting friends: " + e.getMessage());
        }

        return friendNum;
    }

    public boolean sendFriendRequest(int userRequest, int userAccept) {
        try {
            Connection conn = sqlConnect.getInstance().getConnection();
            PreparedStatement st = conn.prepareStatement("INSERT INTO friendship VALUES (?, ?, 'pending')");
            st.setInt(1, userRequest);
            st.setInt(2, userAccept);
            st.executeUpdate();
        } catch (Exception e) {
            System.out.println("An unknown error occurred while sending friend request: " + e.getMessage());
            return false;
        }
        return true;
    }

    public void acceptFriendRequest(int userRequest, int userAccept) {
        try {
            Connection conn = sqlConnect.getInstance().getConnection();
            PreparedStatement st = conn.prepareStatement("UPDATE friendship SET status = 'accepted' WHERE (sender = ? AND receiver = ?) OR (sender = ? AND receiver = ?)");
            st.setInt(1, userRequest);
            st.setInt(2, userAccept);
            st.setInt(3, userAccept);
            st.setInt(4, userRequest);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("SQL Exception occurred while accept friend request: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("An unknown error occurred while accept friend request: " + e.getMessage());
        }
    }

    public void rejectFriendRequest(int userRequest, int userAccept) {
        try {
            Connection conn = sqlConnect.getInstance().getConnection();
            PreparedStatement st = conn.prepareStatement("Delete from friendship where status = 'pending' AND sender = ? AND receiver = ?");
            st.setInt(1, userRequest);
            st.setInt(2, userAccept);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("SQL Exception occurred while reject friend request: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("An unknown error occurred while reject friend request: " + e.getMessage());
        }
    }

    public ArrayList<String> getAllFriendRequest(int userId) throws Exception {
        ArrayList<String> requested_userId_List = new ArrayList<>();
        Connection conn = sqlConnect.getInstance().getConnection();
        PreparedStatement st = conn.prepareStatement("SELECT u.user_id, u.first_name, u.last_name, u.profile_pic FROM friendship f JOIN userAccount u ON f.sender = u.user_id WHERE f.receiver = ? AND f.status = 'pending'");
        st.setInt(1, userId);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            int userRequest = rs.getInt(1);
            String first_name = rs.getString(2);
            String last_name = rs.getString(3);
            String profile_pic = rs.getString(4);
            requested_userId_List.add(userRequest + "." + first_name + "." + last_name + "." + profile_pic);
        }
        return requested_userId_List;
    }

    public String checkFriendStatus(int currUser, int responUser) throws Exception {
        Connection conn = sqlConnect.getInstance().getConnection();
        String status = "Nothing";
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM friendship WHERE (sender = ? AND receiver=?) OR (sender = ? AND receiver = ?)");
        ps.setInt(1, currUser);
        ps.setInt(2, responUser);
        ps.setInt(3, responUser);
        ps.setInt(4, currUser);

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String currentStatus = rs.getString("status");
                if (currentStatus.equals("pending")) {
                    if (rs.getInt("receiver") == currUser && rs.getInt("sender") == responUser) {
                        status = "reverse_pending";
                        return status;
                    } else {
                        status = "pending";
                        return status;
                    }
                } else if (currentStatus.equals("accepted")) {
                    status = "accepted";
                    return status;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return status;
    }

    public ArrayList<User> findFriend(int currUser) throws Exception {
        ArrayList<User> friendList = new ArrayList<>();
        Connection conn = sqlConnect.getInstance().getConnection();
        String storedProcedure = "{call getAllFriends(?)}";
        CallableStatement cstmt = conn.prepareCall(storedProcedure);
        cstmt.setInt(1, currUser);
        ResultSet rs = cstmt.executeQuery();
        while (rs.next()) {
            friendList.add(new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4)));
        }
        return friendList;
    }
}
