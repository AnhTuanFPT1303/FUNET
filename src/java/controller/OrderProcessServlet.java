package controller;

import dao.productDAO;
import dao.shoppingCartDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import model.ShoppingCartItem;
import model.User;

public class OrderProcessServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
        int cartId = Integer.parseInt(request.getParameter("cartId"));
        User currentUser = (User) request.getSession(false).getAttribute("user");
        
        shoppingCartDAO sCartDAO = new shoppingCartDAO();
        productDAO productDAO = new productDAO();

        List<ShoppingCartItem> sCartItemList = null;
        List<Product> productList = null;

        try {
            // Lấy danh sách sản phẩm
            productList = productDAO.getAll();
            
            // Lấy danh sách các mục trong giỏ hàng
            if (cartId != -1) {
                sCartItemList = sCartDAO.getAllItems(cartId);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }

        // Gán các thuộc tính cho request và chuyển đến trang thanh toán
        request.setAttribute("cartId", cartId);
        request.setAttribute("productList", productList);
        request.setAttribute("userId", currentUser.getUser_id());
        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("cartItems", sCartItemList);

        // Chuyển tiếp đến trang xử lý thông tin thanh toán
        request.getRequestDispatcher("WEB-INF/paymentInfoProcess.jsp").forward(request, response);
    }
}
