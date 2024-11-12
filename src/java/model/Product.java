package model;

import java.util.Date;

public class Product {
    
    // model của product
    
    private int productId; 
    private int userId;    
    private String productName; 
    private String productDescription; 
    private String product_img;
    private String productTag; 
    private Date publishDate; 
    private double price; 
    private int quantity;

    public Product(int productId, int userId, String productName, String productDescription, String product_img, String productTag, Date publishDate, double price, int quantity) {
        this.productId = productId;
        this.userId = userId;
        this.productName = productName;
        this.productDescription = productDescription;
        this.product_img = product_img;
        this.productTag = productTag;
        this.publishDate = publishDate;
        this.price = price;
        this.quantity = quantity;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getProduct_img() {
        return product_img;
    }

    public void setProduct_img(String product_img) {
        this.product_img = product_img;
    }

    public int getProductId() {
        return productId;
    }

    public int getUserId() {
        return userId;
    }

    public String getProductName() {
        return productName;
    }

    public String getProductDescription() {
        return productDescription;
    }

    public String getProductTag() {
        return productTag;
    }

    public Date getPublishDate() {
        return publishDate;
    }

    public double getPrice() {
        return price;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public void setProductDescription(String productDescription) {
        this.productDescription = productDescription;
    }

    public void setProductTag(String productTag) {
        this.productTag = productTag;
    }

    public void setPublishDate(Date publishDate) {
        this.publishDate = publishDate;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    
    
}
