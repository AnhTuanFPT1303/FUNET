/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.shoppingCartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.ShoppingCartItem;
import model.User;

public class RemoveItemServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));

        // Lấy session hiện tại
        HttpSession session = request.getSession(false);
        if (session != null) {
            // Lấy userId
            User currentUser = (User) request.getSession(false).getAttribute("user");
            int userId = (int) currentUser.getUser_id();

            // Lấy cartId từ userId bằng DAO
            shoppingCartDAO cartDAO = new shoppingCartDAO();
            try {
                int cartId = cartDAO.getCartIdByUserId(userId);
                if (cartId != -1) {
                    // Xóa sản phẩm khỏi giỏ hàng
                    cartDAO.removeItem(cartId, productId);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            // Cập nhật lại giỏ hàng trong session hoặc chuyển hướng
            response.sendRedirect("/FUNET/marketLink");
        }
    }
}
