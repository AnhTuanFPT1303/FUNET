package controller;

import dao.productDAO;
import dao.shoppingCartDAO;
import jakarta.servlet.ServletException;
import java.io.IOException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;
import model.ShoppingCartItem;
import model.User;

public class marketLink extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        
            productDAO productDAO = new productDAO();
    shoppingCartDAO sCartDAO = new shoppingCartDAO();
    
    User currentUser = (User) request.getSession(false).getAttribute("user");
    int userId = (int) currentUser.getUser_id(); 

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
    
    // Chuyển tiếp request đến market.jsp
    request.getRequestDispatcher("WEB-INF/market.jsp").forward(request, response);
    }

}
