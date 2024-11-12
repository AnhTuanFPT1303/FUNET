package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.game;
import util.sqlConnect;

public class SearchGameDAO {

    public List<game> searchGameByKeyword(String keyword) {
        List<game> list = new ArrayList<>();
        String sql = "SELECT G.GameID, G.GameName, G.GameLink,G.Img , T.CategoryName "
                + "FROM Game G "
                + "JOIN GameCategory T ON G.CategoryID = T.CategoryID "
                + "WHERE G.GameName LIKE ?";

        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + keyword + "%");

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    game game = new game(
                            rs.getInt("GameID"),
                            rs.getString("GameName"),
                            rs.getString("GameLink"),
                            rs.getString("Img"),
                            rs.getString("CategoryName")
                    );
                    list.add(game);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        SearchGameDAO dao = new SearchGameDAO();
        List<game> games = dao.searchGameByKeyword("a");
        for (game game : games) {
            System.out.println(game);
        }
    }
}
