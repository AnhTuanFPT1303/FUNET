/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ordersDAO;
import dao.productDAO;
import dao.shoppingCartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Orders;
import model.Product;
import model.ShoppingCartItem;
import model.User;

public class OrderControlServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            
            ordersDAO oDAO = new ordersDAO();
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String transactionStatus = request.getParameter("transactionStatus");
            productDAO productDAO = new productDAO();
            shoppingCartDAO sCartDAO = new shoppingCartDAO();
            
            User currentUser = (User) request.getSession(false).getAttribute("user");
            int userId = (int) currentUser.getUser_id();
            
            List<Orders> ordersList = oDAO.getAllOrders();
            
            List<ShoppingCartItem> sCartItemList = null;
            List<Product> productList = null;
            double totalAmount = 0.0;
            int cartId = -1;
            try {
                // Lấy danh sách tất cả sản phẩm
                productList = productDAO.getAll();
                
                // Lấy cartId của người dùng hiện tại
                cartId = sCartDAO.getCartIdByUserId(userId);
                
                // Lấy danh sách các item trong giỏ hàng
                if (cartId != -1) {
                    sCartItemList = sCartDAO.getAllItems(cartId);
                }
                
                for (ShoppingCartItem item : sCartItemList) {
                    for (Product product : productList) {
                        if (item.getProductId() == product.getProductId()) {
                            totalAmount += item.getQuantity() * product.getPrice();
                        }
                    }
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            
            // Truyền danh sách sản phẩm và cart item sang JSP
            request.setAttribute("cartId", cartId);
            request.setAttribute("productList", productList);
            request.setAttribute("cartItems", sCartItemList);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("ordersList", ordersList);
            
            sCartDAO.updateOrderDetailbyShoppingCartItem(orderId);
            
            if (transactionStatus.equals(
                    "Fail") || transactionStatus.equals("invalid signature")) {
                try {
                    oDAO.deleteOrder(orderId);
                    // Chuyển tiếp request đến market.jsp
                    response.sendRedirect("marketLink");
                } catch (Exception ex) {
                    Logger.getLogger(OrderControlServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            } else {
                // Chuyển tiếp request đến market.jsp
                response.sendRedirect("marketLink");
            }
        } catch (Exception ex) {
            Logger.getLogger(OrderControlServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
