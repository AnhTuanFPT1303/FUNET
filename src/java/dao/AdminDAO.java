/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Month;
import util.sqlConnect;
/**
 *
 * @author Quocb
 */
public class AdminDAO {
     public boolean updateUserBanStatus(int userId, boolean isBanned) {
        String sql = "UPDATE userAccount SET is_banned = ? WHERE user_id = ?";
        try (Connection conn = sqlConnect.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBoolean(1, isBanned);
            ps.setInt(2, userId);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
     
       public static void main(String[] args) {
       AdminDAO dao=new AdminDAO();
       dao.updateUserBanStatus(1, true);
    }
    
}
