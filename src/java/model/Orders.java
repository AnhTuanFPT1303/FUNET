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
public class Orders {
    
    public int order_id;
    //user_id tinh la buyer_id
    public int user_id;
    public int cart_id;
    public double total_amount;
    public String order_status;
    public Date order_date;
    public String order_note;
    public String shipping_address;

    public Orders(int order_id, int user_id, int cart_id, double total_amount, String order_status, Date order_date, String order_note, String shipping_address) {
        this.order_id = order_id;
        this.user_id = user_id;
        this.cart_id = cart_id;
        this.total_amount = total_amount;
        this.order_status = order_status;
        this.order_date = order_date;
        this.order_note = order_note;
        this.shipping_address = shipping_address;
    }

    public Orders() {

    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getCart_id() {
        return cart_id;
    }

    public void setCart_id(int cart_id) {
        this.cart_id = cart_id;
    }

    public double getTotal_amount() {
        return total_amount;
    }

    public void setTotal_amount(double total_amount) {
        this.total_amount = total_amount;
    }

    public String getOrder_status() {
        return order_status;
    }

    public void setOrder_status(String order_status) {
        this.order_status = order_status;
    }

    public Date getOrder_date() {
        return order_date;
    }

    public void setOrder_date(Date order_date) {
        this.order_date = order_date;
    }

    public String getOrder_note() {
        return order_note;
    }

    public void setOrder_note(String order_note) {
        this.order_note = order_note;
    }

    public String getShipping_address() {
        return shipping_address;
    }

    public void setShipping_address(String shipping_address) {
        this.shipping_address = shipping_address;
    }

    @Override
    public String toString() {
        return "Orders{" + "order_id=" + order_id + ", user_id=" + user_id + ", cart_id=" + cart_id + ", total_amount=" + total_amount + ", order_status=" + order_status + ", order_date=" + order_date + ", order_note=" + order_note + ", shipping_address=" + shipping_address + '}';
    }
}