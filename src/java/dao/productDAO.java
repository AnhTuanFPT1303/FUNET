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
        
        try (Connection conn = sqlConnect.getInstance().getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {
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
                // luu product vao list product
                Product product = new Product(productId, userId, productName, productDescription, product_img, productTag, publishDate, price);
                productList.add(product);  
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return productList;
    }
    // lấy dữ liệu những sản phẩm đang bán của người dùng
    public List<Product> getSellingList(int userId) throws Exception{
        
        List<Product> sellingProductList = new ArrayList<>();
        
        try{
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
                // luu product vao list product
                Product product = new Product(productId, userId, productName, productDescription, product_img, productTag, publishDate, price);
                sellingProductList.add(product);
            }
        } catch (Exception exception) {
            exception.printStackTrace();
        }

        return sellingProductList;
    }

    public void addProduct(Product product) {
        String sql = "INSERT INTO product (user_id, product_name, product_description, product_img, product_tag, publish_date, price) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = sqlConnect.getInstance().getConnection(); PreparedStatement preparedStatement = conn.prepareStatement(sql)) {

            preparedStatement.setInt(1, product.getUserId());
            preparedStatement.setString(2, product.getProductName());
            preparedStatement.setString(3, product.getProductDescription());
            preparedStatement.setString(4, product.getProduct_img());
            preparedStatement.setString(5, product.getProductTag());
            preparedStatement.setDate(6, new java.sql.Date(product.getPublishDate().getTime()));
            preparedStatement.setDouble(7, product.getPrice());
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

                    Product product = new Product(productId, userId, productName, productDescription, product_img, productTag, publishDate, price);
                    searchResults.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return searchResults;
    }

    public static void main(String[] args) throws Exception {
        productDAO prD = new productDAO();
        int userId = prD.getUserIdByProductId(6);
        System.out.println(userId);
    }
}
