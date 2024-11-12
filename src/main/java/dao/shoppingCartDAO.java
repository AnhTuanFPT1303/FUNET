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
import model.OrderDetailDTO;
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
    public void addShoppingCart(int userId) throws SQLException, Exception {
        String sql = "INSERT INTO shoppingCart (user_id, add_date) VALUES (?, GETDATE())";
        connection = sqlConnect.getInstance().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, userId);
        preparedStatement.executeUpdate();
    }

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

    public void updateOrderDetailbyShoppingCartItem(int orderId) throws Exception {
        ordersDAO oDAO = new ordersDAO();
        int cartId = oDAO.getCartIdByOrderId(orderId);

        String sql = "Select shoppingCart.cart_id, shoppingCart.user_id as b_id, shoppingCartItem.product_id as p_id, shoppingCartItem.quantity as quant, product.user_id as p_id, product.price as pr from shoppingCart inner join shoppingCartItem on shoppingCart.cart_id = shoppingCartItem.cart_id inner join product on product.product_id = shoppingCartItem.product_id Where shoppingCart.cart_id = ?";

        shoppingCartDAO sCartDAO = new shoppingCartDAO();

        List<OrderDetailDTO> orderDetailList = new ArrayList<>();

        try (Connection connection = sqlConnect.getInstance().getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, cartId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    int productId = resultSet.getInt("p_id");
                    int quantity = resultSet.getInt("quant");
                    OrderDetailDTO orderDetailDTO = new OrderDetailDTO(
                            orderId,
                            productId,
                            quantity,
                            resultSet.getInt("pr"),
                            "Pending",
                            resultSet.getInt("p_id"),
                            resultSet.getInt("b_id")
                    );
                    orderDetailList.add(orderDetailDTO);

                }
            }

            for (OrderDetailDTO orderDetailDTO : orderDetailList) {
                System.out.println(orderDetailDTO);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        String insertSql = "INSERT INTO OrderDetailDTO (orderid, productid, quantity, price, orderStatus, sellerid, buyerid) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {

            for (OrderDetailDTO orderDetail : orderDetailList) {
                insertStmt.setInt(1, orderDetail.getOrderId());
                insertStmt.setInt(2, orderDetail.getProductId());
                insertStmt.setInt(3, orderDetail.getQuantity());
                insertStmt.setDouble(4, orderDetail.getPrice());
                insertStmt.setString(5, orderDetail.getOrderStatus());
                insertStmt.setInt(6, orderDetail.getSellerID());
                insertStmt.setInt(7, orderDetail.getBuyerID());
                insertStmt.addBatch();  // Add to batch for performance optimization
            }
            insertStmt.executeBatch();  // Execute batch insert

        } catch (Exception e) {
            e.printStackTrace();  // Consider adding better exception handling or logging
        }

        // Delete products from shoppingCartItem
        String deleteSql = "DELETE FROM shoppingCartItem WHERE cart_id = ?";
        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(deleteSql)) {
            stmt.setInt(1, cartId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();  // Consider adding better exception handling or logging
        }
    }

    public boolean increaseProductQuantity(int productId, int quantityToIncrease) throws SQLException, Exception {
        // Lấy số lượng hiện tại của sản phẩm trong kho
        String getQuantitySql = "SELECT quantity FROM product WHERE product_id = ?";
        int currentQuantity = 0;

        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(getQuantitySql)) {
            stmt.setInt(1, productId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    currentQuantity = rs.getInt("quantity");
                }
            }
        }

        // Tăng số lượng sản phẩm trong kho
        String updateQuantitySql = "UPDATE product SET quantity = ? WHERE product_id = ?";

        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(updateQuantitySql)) {
            stmt.setInt(1, currentQuantity + quantityToIncrease);  // Tăng số lượng
            stmt.setInt(2, productId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;  // Trả về true nếu cập nhật thành công
        }
    }

    public boolean reduceProductQuantity(int productId, int quantityBought) throws SQLException, Exception {
        // Lấy số lượng hiện tại của sản phẩm trong kho
        String getQuantitySql = "SELECT quantity FROM product WHERE product_id = ?";
        int currentQuantity = 0;

        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(getQuantitySql)) {
            stmt.setInt(1, productId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    currentQuantity = rs.getInt("quantity");
                }
            }
        }

        // Kiểm tra xem số lượng mua có lớn hơn số lượng hiện có trong kho không
        if (quantityBought > currentQuantity) {
            return false;  // Không thể giảm số lượng vì sản phẩm không đủ trong kho
        }

        // Giảm số lượng sản phẩm trong kho
        String updateQuantitySql = "UPDATE product SET quantity = ? WHERE product_id = ?";

        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(updateQuantitySql)) {
            stmt.setInt(1, currentQuantity - quantityBought);
            stmt.setInt(2, productId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;  // Trả về true nếu cập nhật thành công
        }
    }

    public static void main(String[] args) throws Exception {

    }

}
