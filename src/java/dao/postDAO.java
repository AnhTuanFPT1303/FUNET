/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author bim26
 */
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Comment;
import model.Post;
import util.sqlConnect;

public class postDAO {

    public void addPost(Post p) {
        String query = "INSERT INTO post (user_id, body, image_path, post_time  ) VALUES (?, ?, ?, CURRENT_TIMESTAMP)";

        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, p.getUser_id());
            stmt.setString(2, p.getBody());
            stmt.setString(3, p.getImage_path());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void addComment(Comment c) {
        String query = "INSERT INTO comment (post_id, user_id, comment_text ) VALUES (?, ?, ?)";
        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, c.getPost_id());
            stmt.setInt(2, c.getUser_id());
            stmt.setString(3, c.getComment_text());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void addLike(int userId, int postId) throws SQLException {
        String insertLike = "INSERT INTO post_like (user_id, post_id) VALUES (?, ?)";
        String updatePostCount = "UPDATE post SET like_count = like_count + 1 WHERE post_id = ?";

        try (Connection conn = sqlConnect.getInstance().getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement pstmt1 = conn.prepareStatement(insertLike); PreparedStatement pstmt2 = conn.prepareStatement(updatePostCount)) {

                pstmt1.setInt(1, userId);
                pstmt1.setInt(2, postId);
                pstmt1.executeUpdate();

                pstmt2.setInt(1, postId);
                pstmt2.executeUpdate();

                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void removeLike(int userId, int postId) throws SQLException {
        String deleteLike = "DELETE FROM post_like WHERE user_id = ? AND post_id = ?";
        String updatePostCount = "UPDATE post SET like_count = like_count - 1 WHERE post_id = ?";

        try (Connection conn = sqlConnect.getInstance().getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement pstmt1 = conn.prepareStatement(deleteLike); PreparedStatement pstmt2 = conn.prepareStatement(updatePostCount)) {

                pstmt1.setInt(1, userId);
                pstmt1.setInt(2, postId);
                pstmt1.executeUpdate();

                pstmt2.setInt(1, postId);
                pstmt2.executeUpdate();

                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public boolean hasUserLikedPost(int userId, int postId) throws SQLException {
        String query = "SELECT COUNT(*) FROM post_like WHERE user_id = ? AND post_id = ?";
        try (Connection conn = sqlConnect.getInstance().getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, postId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public int getLikeCount(int postId) throws SQLException {
        String query = "SELECT like_count FROM post WHERE post_id = ?";
        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, postId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("like_count");
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public static List<Post> getAllPosts(int sessionUserId) {
        List<Post> posts = new ArrayList<>();
        try {
            ResultSet rs = null;
            Connection conn = null;
            PreparedStatement  stmt = null;
            conn = sqlConnect.getInstance().getConnection();

            String query = "SELECT DISTINCT p.post_id, p.body, p.post_time, p.user_id, p.image_path, p.like_count, u.first_name, u.last_name, u.profile_pic "
                    + "FROM post p "
                    + "JOIN userAccount u ON p.user_id = u.user_id "
                    + "WHERE p.user_id = ? "
                    + "OR p.user_id IN ( "
                    + "    SELECT CASE "
                    + "        WHEN f.user_request = ? THEN f.user_accept "
                    + "        ELSE f.user_request "
                    + "    END "
                    + "    FROM friendship f "
                    + "    WHERE f.status = 'accepted' "
                    + "    AND (? IN (f.user_request, f.user_accept)) "
                    + ") "
                    + "ORDER BY p.post_time DESC";

            stmt = conn.prepareStatement(query);
            stmt.setInt(1, sessionUserId);
            stmt.setInt(2, sessionUserId);
            stmt.setInt(3, sessionUserId);

            rs = stmt.executeQuery();

            while (rs.next()) {
                int post_id = rs.getInt("post_id");
                int user_id = rs.getInt("user_id");
                String body = rs.getString("body");
                Timestamp post_time = rs.getTimestamp("post_time");
                String first_name = rs.getString("first_name");
                String last_name = rs.getString("last_name");
                String image_path = rs.getString("image_path");
                int like_count = rs.getInt("like_count");
                String profile_pic = rs.getString("profile_pic");
                Post post = new Post(post_id, user_id, body, post_time, first_name, last_name, image_path, profile_pic, like_count);
                post.setComments(getComments(post.getPost_id()));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return posts;
    }

    public static List<Comment> getComments(int postId) {
        List<Comment> comments = new ArrayList<>();
        try {
            ResultSet rs = null;
            Connection conn = null;
            PreparedStatement stmt = null;
            conn = sqlConnect.getInstance().getConnection();
            stmt = conn.prepareStatement("SELECT c.comment_id, c.post_id, c.user_id, c.comment_text, u.first_name, u.last_name, u.profile_pic "
                    + "FROM comment c "
                    + "JOIN userAccount u ON c.user_id = u.user_id "
                    + "WHERE c.post_id = ? "
                    + "ORDER BY c.comment_id ASC;");
            stmt.setInt(1, postId);
            rs = stmt.executeQuery();
            while (rs.next()) {
                int comment_id = rs.getInt("comment_id");
                int post_id = rs.getInt("post_id");
                int user_id = rs.getInt("user_id");
                String comment_text = rs.getString("comment_text");
                String first_name = rs.getString("first_name");
                String last_name = rs.getString("last_name");
                String profile_pic = rs.getString("profile_pic");
                Comment comment = new Comment(comment_id, post_id, user_id, first_name, last_name, comment_text, profile_pic);
                comments.add(comment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return comments;
    }

    public static List<Post> getMyPosts(int userId) {
        List<Post> posts = new ArrayList<>();
        try {
            ResultSet rs = null;
            Connection conn = null;
            PreparedStatement stmt = null;
            conn = sqlConnect.getInstance().getConnection();
            stmt = conn.prepareStatement("SELECT p.post_id, p.body, p.post_time, p.user_id, p.like_count, p.image_path, u.first_name, u.last_name "
                    + "FROM post p JOIN userAccount u ON p.user_id = u.user_id "
                    + "WHERE p.user_id =? "
                    + "ORDER BY p.post_time DESC"
                    + "offset 20 rows fetch next 20 rows only");
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();
            while (rs.next()) {
                int post_id = rs.getInt("post_id");
                int user_id = rs.getInt("user_id");
                String body = rs.getString("body");
                Timestamp post_time = rs.getTimestamp("post_time");
                String first_name = rs.getString("first_name");
                String last_name = rs.getString("last_name");
                int like_count = rs.getInt("like_count");
                String image_path = rs.getString("image_path");
                Post post = new Post(post_id, user_id, body, post_time, first_name, last_name, image_path, like_count);
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return posts;
    }

    public void deletePost(int postId) {
        String deletePostQuery = "DELETE FROM post WHERE post_id = ?";

        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(deletePostQuery)) {
            stmt.setInt(1, postId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
