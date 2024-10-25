/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.ArrayList;
import model.ShoppingCart;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.ShoppingCartItem;
import util.sqlConnect;

/**
 *
 * @author ADMIN
 */
public class shoppingCartDAO {

    private Connection connection;

    public List<ShoppingCart> getAllCarts() throws Exception {
        List<ShoppingCart> shoppingList = new ArrayList<>();
        // ket noi sql va lay thong tin list shopping cart tu database
        String sql = "SELECT * FROM shoppingCart";

        try {
            connection = sqlConnect.getInstance().getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int cart_id = resultSet.getInt("cart_id");
                int user_id = resultSet.getInt("user_id");
                Date add_date = resultSet.getDate("add_date");

                ShoppingCart shoppingCart = new ShoppingCart(cart_id, user_id, add_date);
                shoppingList.add(shoppingCart);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return shoppingList;
    }

    public List<ShoppingCartItem> getAllItems(int cart_id) throws Exception {
        List<ShoppingCartItem> shoppingItemList = new ArrayList<>();
        String sql = "SELECT * FROM shoppingCartItem WHERE cart_id = ?";

        try {
            connection = sqlConnect.getInstance().getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            // Đặt giá trị cart_id cho câu truy vấn
            preparedStatement.setInt(1, cart_id);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                int item_id = resultSet.getInt("item_id");
                cart_id = resultSet.getInt("cart_id");  // Bạn có thể giữ nguyên giá trị cart_id ở đây
                int product_id = resultSet.getInt("product_id");
                int quantity = resultSet.getInt("quantity");
                Date add_date = resultSet.getDate("added_at");

                ShoppingCartItem shoppingItem = new ShoppingCartItem(item_id, cart_id, product_id, quantity, add_date);
                shoppingItemList.add(shoppingItem);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return shoppingItemList;
    }

    // Tạo giỏ hàng
//    public void addShoppingCart(int userId) throws SQLException, Exception {
//        String sql = "INSERT INTO shoppingCart (user_id, add_date) VALUES (?, GETDATE())";
//        connection = sqlConnect.getInstance().getConnection();
//        PreparedStatement preparedStatement = connection.prepareStatement(sql);
//        preparedStatement.setInt(1, userId);
//        preparedStatement.executeUpdate();
//    }

    // Thêm item vào shopping cart
    public boolean addShoppingCartItem(int cartId, int productId, int quantity) throws SQLException, Exception {
        String sql = "INSERT INTO shoppingCartItem (cart_id, product_id, quantity) VALUES (?, ?, ?)";
        connection = sqlConnect.getInstance().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, cartId);
        preparedStatement.setInt(2, productId);
        preparedStatement.setInt(3, quantity);

        int rowsAffected = preparedStatement.executeUpdate();
        return rowsAffected > 0; // Trả về true nếu có ít nhất 1 dòng bị ảnh hưởng
    }

    public int getCartIdByUserId(int userId) throws Exception {
        String sql = "SELECT cart_id FROM shoppingCart WHERE user_id = ?";
        connection = sqlConnect.getInstance().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, userId);
        ResultSet resultSet = preparedStatement.executeQuery();

        if (resultSet.next()) {
            return resultSet.getInt("cart_id");
        } else {
            return -1; // Nếu không có giỏ hàng
        }
    }

    public int getUserIdByCartId(int cartId) throws Exception {
        String sql = "SELECT user_id FROM shoppingCart WHERE cart_id = ?";
        int userId = -1;

        try (Connection connection = sqlConnect.getInstance().getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, cartId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                userId = resultSet.getInt("user_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return userId;
    }

    // Phương thức xóa sản phẩm khỏi giỏ hàng
    public void removeItem(int cartId, int productId) throws SQLException, Exception {
        String sql = "DELETE FROM shoppingCartItem WHERE cart_id = ? AND product_id = ?";
        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartId);
            stmt.setInt(2, productId);
            stmt.executeUpdate();
        }
    }

    public static void main(String[] args) throws Exception {
        shoppingCartDAO s = new shoppingCartDAO();
        System.out.println(s.getUserIdByCartId(4));
    }

}
