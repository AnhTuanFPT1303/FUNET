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
public class ShoppingCart {
    
    public int cart_id;
    public int user_id;
    public Date add_date;

    public ShoppingCart(int cart_id, int user_id, Date add_date) {
        this.cart_id = cart_id;
        this.user_id = user_id;
        this.add_date = add_date;
    }

    public int getCart_id() {
        return cart_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public Date getAdd_date() {
        return add_date;
    }

    public void setCart_id(int cart_id) {
        this.cart_id = cart_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public void setAdd_date(Date add_date) {
        this.add_date = add_date;
    }
}
