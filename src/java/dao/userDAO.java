package dao;

import Security.SHA512WithSalt;
import util.sqlConnect;
import java.sql.*;
import model.User;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


public class userDAO {

    private static userDAO instance = null;

    public userDAO() {

    }

    public synchronized static userDAO getInstance() {
        if (instance == null) {
            instance = new userDAO();
        }
        return instance;
    }

    public boolean login(String email, String password) {
        boolean result = false;
        try {
            Connection conn = sqlConnect.getInstance().getConnection();
            PreparedStatement st = conn.prepareStatement("SELECT * FROM userAccount WHERE email=?");
            st.setString(1, email);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                // Lấy chuỗi kết hợp (lưu cả salt và sha512 hash vào password)
                String combinedHash = rs.getString("password");

                // Tách salt và hashedPassword
                String[] parts = combinedHash.split(":"); // Sử dụng dấu phân cách
                byte[] salt = Base64.getDecoder().decode(parts[0]); // Giải mã salt
                String storedHash = parts[1]; // hashedPassword

                // Băm mật khẩu đã nhập với salt
                String hashedInputPassword = SHA512WithSalt.hashPassWordWithSHA512(password, salt);

                // So sánh mật khẩu đã băm
                if (hashedInputPassword.equals(storedHash)) {
                    result = true;
                }
            }
        } catch (Exception e) {
            System.out.println("Connect Failed: " + e.getMessage());
        }
        return result;
    }
    
    public void hashPw(String firstName, String lastName, String email, String password, String profilePic, String role) throws Exception {
        userDAO uDAO = new userDAO(); // Giả định UserDAO có phương thức register

        // Bước 1: Mã hóa mật khẩu với salt
        byte[] salt = SHA512WithSalt.createSalt(); // Tạo salt
        String hashedPassword = SHA512WithSalt.hashPassWordWithSHA512(password, salt); // Băm mật khẩu với SHA-512
        String combinedHash = Base64.getEncoder().encodeToString(salt) + ":" + hashedPassword; // Kết hợp salt và mật khẩu đã băm

        // Bước 2: Tạo đối tượng User mới
        User newUser = new User(firstName, lastName, combinedHash, email, profilePic, role, false); // false ở đây là is_banned

        // Bước 3: Gọi phương thức register để thêm người dùng vào cơ sở dữ liệu
        int userId = uDAO.register(newUser);  // Phương thức register trả về userId nếu thành công

        // Bước 4: Kiểm tra kết quả đăng ký
        if (userId > 0) {
            System.out.println("Đăng ký thành công cho email: " + email + " với userId: " + userId);
        } else {
            System.out.println("Đăng ký thất bại cho email: " + email);
        }
    }

    public int register(User user) throws Exception {
        // tạo giỏ hàng cho người dùng khi register
        shoppingCartDAO sCartDAO = new shoppingCartDAO();
        sCartDAO.addShoppingCart(user.getUser_id());
        
        int generatedUserId = 0;
        String sql = "INSERT INTO userAccount (first_name, last_name, password, email, profile_pic, role, is_banned) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getFirst_name());
            ps.setString(2, user.getLast_name());
            ps.setString(3, user.getPassword()); // Password should be null for Google login
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getProfile_pic());
            ps.setString(6, user.getRole());
            ps.setBoolean(7, user.getStatus());

            ps.executeUpdate();
            
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                generatedUserId = rs.getInt(1); // Get the generated user_id
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return generatedUserId;
        
    }

    public User getUserByEmail(String email) {
        User user = null;
        String sql = "SELECT * FROM userAccount WHERE email = ?";

        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUser_id(rs.getInt("user_id"));
                user.setFirst_name(rs.getString("first_name"));
                user.setLast_name(rs.getString("last_name"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setProfile_pic(rs.getString("profile_pic"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getBoolean("is_banned"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
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
                u.setEmail(rs.getString(5));
                u.setProfile_pic(rs.getString(6));
                u.setRole(rs.getString(7));
                u.setStatus(false);
            }

        } catch (Exception e) {
            System.out.println("Action Failed");
        }
        return u;
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
                 u.setRole(rs.getString("role"));
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
                    + "INNER JOIN friendship f ON (u.user_id = f.sender OR u.user_id = f.receiver) "
                    + "WHERE ((f.sender = ? OR f.receiver = ?) AND u.user_id != ? AND f.status = 'accepted')"
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

    public void changeAvatar(User u) {
        String query = "UPDATE userAccount SET profile_pic =? WHERE user_id =?";
        try {
            Connection conn = sqlConnect.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, u.getProfile_pic());
            stmt.setInt(2, u.getUser_id());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void changePassword(String password, String email) {
        String query = "UPDATE userAccount SET password =? WHERE email =?";
        try {
            Connection conn = sqlConnect.getInstance().getConnection();
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, password);
            stmt.setString(2, email);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public ArrayList<User> findFriendsByKeyWord(int userId, String keyWord) throws SQLException, Exception {
        String sql = "SELECT u.user_id, u.profile_pic, u.first_name, u.last_name "
                + "FROM userAccount u "
                + "WHERE u.user_id != ? AND (u.first_name LIKE ? OR u.last_name LIKE ?)";

        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setString(2, "%" + keyWord + "%");
            ps.setString(3, "%" + keyWord + "%");

            ResultSet rs = ps.executeQuery();
            ArrayList<User> users = new ArrayList<>();
            while (rs.next()) {
                User user = new User();
                user.setUser_id(rs.getInt("user_id"));
                user.setProfile_pic(rs.getString("profile_pic"));
                user.setFirst_name(rs.getString("first_name"));
                user.setLast_name(rs.getString("last_name"));
                users.add(user);
            }
            return users;
        }
    }

    public List<User> findUsersByConversationId(int conversationId) throws SQLException, Exception {
        String sql = "SELECT u.user_id, u.profile_pic, u.last_name, u.first_name, cu.is_admin "
                + "FROM userAccount u "
                + "JOIN conversation_users cu ON u.user_id = cu.user_id "
                + "WHERE cu.conversation_id = ?";

        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, conversationId);

            ResultSet rs = ps.executeQuery();
            List<User> users = new ArrayList<>();
            while (rs.next()) {
                User user = new User();
                user.setUser_id(rs.getInt("user_id"));
                user.setProfile_pic(rs.getString("profile_pic"));
                user.setFirst_name("first_name");
                user.setLast_name("last_name");
                user.setAdmin(rs.getBoolean("is_admin"));
                users.add(user);
            }
            return users;
        }
    }

    public List<User> getFriendsNotInConversation(int userId, String keyword, int conversationId) throws SQLException, Exception {
        String sql = "SELECT u2.user_id, u2.profile_pic, u2.last_name, u2.first_name"
                + "FROM userAccount u1 "
                + "JOIN friendship f ON u1.user_id = f.receiver "
                + "JOIN userAccount u2 ON u2.user_id = f.sender "
                + "WHERE u1.user_id = ? AND f.status = 1 AND (u2.first_name LIKE ? OR u2.last_name LIKE ?) "
                + "AND u2.user_id NOT IN ( "
                + "    SELECT u.user_id FROM userAccount u "
                + "    JOIN conversations_users cu ON u.user_id = cu.user_id "
                + "    WHERE cu.conversation_id = ? )";

        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setString(2, "%" + keyword + "%");
            ps.setString(3, "%" + keyword + "%");
            ps.setInt(4, conversationId);

            ResultSet rs = ps.executeQuery();
            List<User> users = new ArrayList<>();
            while (rs.next()) {
                User user = new User();
                user.setUser_id(rs.getInt("user_id"));
                user.setProfile_pic(rs.getString("profile_pic"));
                user.setFirst_name("first_name");
                user.setLast_name("last_name");
                users.add(user);
            }
            return users;
        }

    }

    public void updateUserIntroduction(int userId, String introduction) {
    String query = "UPDATE userAccount SET user_introduce = ? WHERE user_id = ?";
    try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
        stmt.setString(1, introduction);
        stmt.setInt(2, userId);
        stmt.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }   catch (Exception ex) {
            ex.printStackTrace();
        }
}

    public String getUserIntroduce(int sessionUserId) {
        String query = "SELECT user_introduce FROM userAccount WHERE user_id = ?";
        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(query)){
            stmt.setInt(1, sessionUserId);
            try (ResultSet rs = stmt.executeQuery()) {
                if(rs.next()){
                    return rs.getString("user_introduce");
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return "Xin chao`";
    }
    public static void main(String[] args) throws SQLException, Exception {
        List<User> list = userDAO.getInstance().findFriendsByKeyWord(1, "t");
        System.out.println(list.get(0).getLast_name());
    }
}
