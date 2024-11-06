/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.UserActivityLog;
import util.sqlConnect;

/**
 *
 * @author Quocb
 */
public class UserActivityDAO {

    public List<UserActivityLog> getUserActivities(int userId) {
        List<UserActivityLog> activities = new ArrayList<>();
        String sql = "SELECT * FROM UserActivityLog ul JOIN userAccount u ON ul.user_id=u.user_id WHERE u.user_id = ? ORDER BY timestamp DESC";
        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                UserActivityLog log = new UserActivityLog();
                log.setLogId(rs.getInt("log_id"));
                log.setUserId(rs.getInt("user_id"));
                log.setRole(rs.getString("role"));
                log.setFirstName(rs.getString("first_name"));
                log.setLastName(rs.getString("last_name"));
                log.setPostId(rs.getInt("post_id"));
                log.setCommentId(rs.getInt("comment_id"));
                log.setActivityType(rs.getString("activity_type"));
                log.setActivityDetails(rs.getString("activity_details"));
                log.setTimestamp(rs.getTimestamp("timestamp").toLocalDateTime());
                activities.add(log);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return activities;
    }

    public List<UserActivityLog> geAlltUserActivities() {
        List<UserActivityLog> activities = new ArrayList<>();
        String sql = "SELECT * FROM UserActivityLog ul JOIN userAccount u ON ul.user_id=u.user_id  ORDER BY timestamp DESC";
        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                UserActivityLog log = new UserActivityLog();
                log.setLogId(rs.getInt("log_id"));
                log.setUserId(rs.getInt("user_id"));
                log.setRole(rs.getString("role"));
                log.setFirstName(rs.getString("first_name"));
                log.setLastName(rs.getString("last_name"));
                log.setPostId(rs.getInt("post_id"));
                log.setCommentId(rs.getInt("comment_id"));
                log.setActivityType(rs.getString("activity_type"));
                log.setActivityDetails(rs.getString("activity_details"));
                log.setTimestamp(rs.getTimestamp("timestamp").toLocalDateTime());
                activities.add(log);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return activities;
    }

    public void deleteUserActivityById(int logId) {
        String sql = "DELETE FROM UserActivityLog WHERE log_id = ?";
        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, logId);
            int rowsAffected = stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();

        }
    }

    public void deleteUserActivityByCommentId(int commentId) {
        String sql = "DELETE FROM UserActivityLog WHERE comment_id = ?";
        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, commentId);
            int rowsAffected = stmt.executeUpdate();

          
        } catch (SQLException e) {
            e.printStackTrace();
            } catch (Exception e) {
            e.printStackTrace();
            
        }
    }

    public void deleteUserActivityByPostId(int postId) {
        String sql = "DELETE FROM UserActivityLog WHERE post_id = ?";
        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, postId);
            int rowsAffected = stmt.executeUpdate();

            
        } catch (SQLException e) {
            e.printStackTrace();
           } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        UserActivityDAO dao = new UserActivityDAO();
        List<UserActivityLog> a = dao.geAlltUserActivities();
        for (UserActivityLog s : a) {
            System.out.println(s);
        }
    }

}
