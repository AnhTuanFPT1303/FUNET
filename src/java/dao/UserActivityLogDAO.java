/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author gabri
 */

import model.UserActivityLog;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import util.sqlConnect;

public class UserActivityLogDAO {

    public List<UserActivityLog> getUserActivities(int userId) {
        List<UserActivityLog> activities = new ArrayList<>();
        String sql = "SELECT * FROM UserActivityLog WHERE user_id = ?";
        try (Connection conn = sqlConnect.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    UserActivityLog activity = new UserActivityLog(
                        rs.getInt("log_id"),
                        rs.getInt("user_id"),
                        rs.getString("activity_type"),
                        rs.getString("activity_details"),
                        rs.getTimestamp("timestamp").toLocalDateTime()
                    );
                    activities.add(activity);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return activities;
    }
    public static void main(String[] args) {
        UserActivityLogDAO dao= new UserActivityLogDAO();
        List<UserActivityLog> a= dao.getUserActivities(13);
        for (UserActivityLog a1 : a) {
            System.out.println(a1);
        }
    }
    
    
}