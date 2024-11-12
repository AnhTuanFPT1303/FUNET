/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author ADMIN
 */
public class OrderDetailDTO {
    private int orderId;
    private int productId;
    private int quantity;
    private double price;
    private String orderStatus;
    private int sellerID;
    private int buyerID;

    public OrderDetailDTO(int orderId, int productId, int quantity, double price, String orderStatus, int sellerID, int buyerID) {
        this.orderId = orderId;
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
        this.orderStatus = orderStatus;
        this.sellerID = sellerID;
        this.buyerID = buyerID;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public int getSellerID() {
        return sellerID;
    }

    public void setSellerID(int sellerID) {
        this.sellerID = sellerID;
    }

    public int getBuyerID() {
        return buyerID;
    }

    public void setBuyerID(int buyerID) {
        this.buyerID = buyerID;
    }

    @Override
    public String toString() {
        return "OrderDetailDTO{" + "orderId=" + orderId + ", productId=" + productId + ", quantity=" + quantity + ", price=" + price + ", orderStatus=" + orderStatus + ", sellerID=" + sellerID + ", buyerID=" + buyerID + '}';
    }
}
