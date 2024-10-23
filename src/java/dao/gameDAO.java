package dao;

import model.game;
import util.sqlConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class gameDAO {
    public List<game> getAllGames() {
        List<game> games = new ArrayList<>();
        String sql = "SELECT G.GameID, G.GameName, G.GameLink, T.CategoryName " +
                     "FROM Game G " +
                     "JOIN GameCategory T ON G.CategoryID = T.CategoryID";
        
        try (Connection conn = sqlConnect.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                game Game = new game(
                    rs.getInt("GameID"),
                    rs.getString("GameName"),
                    rs.getString("GameLink"),
                    rs.getString("CategoryName")
                );
                games.add(Game);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return games;
    }

    public static void main(String[] args) {
        gameDAO dao = new gameDAO();
        List<game> games = dao.getAllGames();
        for (game game : games) {
            System.out.println(game);
        }
    }
}