/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.productDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.Date;
import java.util.List;
import model.Product;
import model.User;

@MultipartConfig
public class ProductUploadServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin sản phẩm từ form
        String productName = request.getParameter("productName");
        String productDescription = request.getParameter("productDescription");
        String productTag = request.getParameter("productTag");
        double price = Double.parseDouble(request.getParameter("price"));

        // Lấy thông tin người dùng từ session
        HttpSession session = request.getSession();
        User currentUser = (User) request.getSession(false).getAttribute("user");
        int userId = (int) currentUser.getUser_id();

        // Lấy file hình ảnh
        Part filePart = request.getPart("productImage");
        String fileName = filePart.getSubmittedFileName();

        // Tạo đường dẫn để lưu hình ảnh
        String uploadPath = getServletContext().getRealPath("") + "assets/product"; // Đường dẫn đầy đủ
        File uploadDir = new File(uploadPath);

        // Tạo thư mục nếu chưa tồn tại
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // Tạo thư mục cha nếu cần
        }

        // Lưu file hình ảnh vào hệ thống
        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        // Lưu đường dẫn tương đối vào cơ sở dữ liệu
        String relativePath = "assets/product/" + fileName;

        // Tạo sản phẩm mới
        Product product = new Product(0, userId, productName, productDescription, relativePath, productTag, new Date(), price);

        // Thêm sản phẩm vào cơ sở dữ liệu
        productDAO dao = new productDAO();
        dao.addProduct(product);

        // Chuyển hướng về trang chinhs
        productDAO productDAO = new productDAO();

        List<Product> productList = null;
        try {
            productList = productDAO.getAll();
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        request.setAttribute("productList", productList);

        request.getRequestDispatcher("WEB-INF/market.jsp").forward(request, response);
    }
}
