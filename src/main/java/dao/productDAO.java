package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import util.sqlConnect;

public class productDAO {

    public List<Product> getAll() throws Exception {

        List<Product> productList = new ArrayList<>();

        String sql = "SELECT * FROM product";

        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement preparedStatement = conn.prepareStatement(sql); ResultSet resultSet = preparedStatement.executeQuery()) {
            // ket noi sql va lay thong tin product ra khoi sql
            while (resultSet.next()) {
                int productId = resultSet.getInt("product_id");
                int userId = resultSet.getInt("user_id");
                String productName = resultSet.getString("product_name");
                String productDescription = resultSet.getString("product_description");
                String product_img = resultSet.getString("product_img");
                String productTag = resultSet.getString("product_tag");

                java.util.Date publishDate = resultSet.getDate("publish_date");

                double price = resultSet.getDouble("price");
                int quantity = resultSet.getInt("quantity");
                // luu product vao list product
                Product product = new Product(productId, userId, productName, productDescription, product_img, productTag, publishDate, price, quantity);
                productList.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productList;
    }

    public Product getProductById(int productId) throws Exception {
        Product product = null;

        try {
            Connection conn = sqlConnect.getInstance().getConnection();
            PreparedStatement preparedStatement = conn.prepareStatement("SELECT * FROM product WHERE product_id = ?");
            preparedStatement.setInt(1, productId);
            ResultSet resultSet = preparedStatement.executeQuery();

            // Kiểm tra nếu có kết quả trả về
            if (resultSet.next()) {
                int userId = resultSet.getInt("user_id");
                String productName = resultSet.getString("product_name");
                String productDescription = resultSet.getString("product_description");
                String product_img = resultSet.getString("product_img");
                String productTag = resultSet.getString("product_tag");
                java.util.Date publishDate = resultSet.getDate("publish_date");
                double price = resultSet.getDouble("price");
                int quantity = resultSet.getInt("quantity");

                // Tạo đối tượng Product với thông tin từ cơ sở dữ liệu
                product = new Product(productId, userId, productName, productDescription, product_img, productTag, publishDate, price, quantity);
            }
        } catch (Exception exception) {
            exception.printStackTrace();
        }

        return product;
    }

    // lấy dữ liệu những sản phẩm đang bán của người dùng
    public List<Product> getSellingList(int userId) throws Exception {

        List<Product> sellingProductList = new ArrayList<>();

        try {
            Connection conn = sqlConnect.getInstance().getConnection();
            PreparedStatement preparedStatement = conn.prepareStatement("Select * from product where user_id = ?");
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            //ket noi sql va lay thong tin product tu database
            while (resultSet.next()) {
                int productId = resultSet.getInt("product_id");
                String productName = resultSet.getString("product_name");
                String productDescription = resultSet.getString("product_description");
                String product_img = resultSet.getString("product_img");
                String productTag = resultSet.getString("product_tag");

                java.util.Date publishDate = resultSet.getDate("publish_date");

                double price = resultSet.getDouble("price");
                int quantity = resultSet.getInt("quantity");
                // luu product vao list product
                Product product = new Product(productId, userId, productName, productDescription, product_img, productTag, publishDate, price, quantity);
                sellingProductList.add(product);
            }
        } catch (Exception exception) {
            exception.printStackTrace();
        }

        return sellingProductList;
    }

    public void addProduct(Product product) {
        String sql = "INSERT INTO product (user_id, product_name, product_description, product_img, product_tag, publish_date, price, quantity) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement preparedStatement = conn.prepareStatement(sql)) {

            preparedStatement.setInt(1, product.getUserId());
            preparedStatement.setString(2, product.getProductName());
            preparedStatement.setString(3, product.getProductDescription());
            preparedStatement.setString(4, product.getProduct_img());
            preparedStatement.setString(5, product.getProductTag());
            preparedStatement.setDate(6, new java.sql.Date(product.getPublishDate().getTime()));
            preparedStatement.setDouble(7, product.getPrice());
            preparedStatement.setInt(8, product.getQuantity());
            preparedStatement.executeUpdate();
        } catch (Exception exception) {
            exception.printStackTrace();
        }
    }

    // test case
    public void printProductList() throws Exception {
        List<Product> productList = getAll();

        if (productList == null || productList.isEmpty()) {
            System.out.println("No products available.");
        } else {
            System.out.println("Product List:");
            for (Product product : productList) {
                System.out.println("Product ID: " + product.getProductId());
                System.out.println("User ID: " + product.getUserId());
                System.out.println("Product Name: " + product.getProductName());
                System.out.println("Description: " + product.getProductDescription());
                System.out.println("Image: " + product.getProduct_img());
                System.out.println("Tag: " + product.getProductTag());
                System.out.println("Published Date: " + product.getPublishDate());
                System.out.println("Price: " + product.getPrice());
                System.out.println("--------------------------------------------");
            }
        }
    }

    public boolean deleteProduct(int productId) throws SQLException, Exception {
        String sql = "DELETE FROM product WHERE product_id = ?";
        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
            preparedStatement.setInt(1, productId);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public int getUserIdByProductId(int productId) throws Exception {
        String sql = "SELECT user_id FROM product WHERE product_id = ?";
        int userId = -1;

        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement preparedStatement = conn.prepareStatement(sql)) {

            preparedStatement.setInt(1, productId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    userId = resultSet.getInt("user_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return userId;
    }

    public List<Product> searchProducts(String keyword) throws Exception {
        List<Product> searchResults = new ArrayList<>();

        String sql = "SELECT * FROM product WHERE product_name LIKE ? OR product_description LIKE ?";

        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement preparedStatement = conn.prepareStatement(sql)) {

            // Sử dụng dấu % để tìm kiếm các sản phẩm có chứa từ khóa
            preparedStatement.setString(1, "%" + keyword + "%");
            preparedStatement.setString(2, "%" + keyword + "%");

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    int productId = resultSet.getInt("product_id");
                    int userId = resultSet.getInt("user_id");
                    String productName = resultSet.getString("product_name");
                    String productDescription = resultSet.getString("product_description");
                    String product_img = resultSet.getString("product_img");
                    String productTag = resultSet.getString("product_tag");
                    java.util.Date publishDate = resultSet.getDate("publish_date");
                    double price = resultSet.getDouble("price");
                    int quantity = resultSet.getInt("quantity");

                    Product product = new Product(productId, userId, productName, productDescription, product_img, productTag, publishDate, price, quantity);
                    searchResults.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return searchResults;
    }

    public boolean updateProductQuantityAndPrice(int productId, int quantity, double price) throws Exception {
        String sql = "UPDATE Product SET quantity = ?, price = ? WHERE product_id = ?";
        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, quantity);
            stmt.setDouble(2, price);
            stmt.setInt(3, productId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            return false;
        }
    }

    public static void main(String[] args) throws Exception {
        productDAO prD = new productDAO();
        int userId = prD.getUserIdByProductId(6);
        System.out.println(userId);
    }
}
