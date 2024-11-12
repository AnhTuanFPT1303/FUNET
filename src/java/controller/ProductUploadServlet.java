package controller;

import com.cloudinary.utils.ObjectUtils;
import dao.productDAO;
import model.Product;
import model.User;
import util.CloudinaryAPI;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 10, // 10 MB
        maxFileSize = 1024 * 1024 * 50, // 50 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class ProductUploadServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ProductUploadServlet.class.getName());
    private static final Set<String> ALLOWED_IMAGE_TYPES = new HashSet<>(Arrays.asList(
            "image/jpeg", "image/png", "image/gif", "image/bmp", "image/webp"
    ));

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("user");

        // Validate if user is logged in
        if (currentUser == null) {
            LOGGER.warning("Unauthorized access attempt - redirecting to login");
            response.sendRedirect("login");
            return;
        }

        String productName = request.getParameter("productName");
        String productDescription = request.getParameter("productDescription");
        String productTag = request.getParameter("productTag");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        double price = Double.parseDouble(request.getParameter("price"));
        Part filePart = request.getPart("productImage");
        String imageUrl = null;

        // Handle file upload if present
        if (filePart != null && filePart.getSize() > 0) {
            String contentType = filePart.getContentType();
            if (!ALLOWED_IMAGE_TYPES.contains(contentType)) {
                LOGGER.warning("Unsupported file type attempted: " + contentType);
                request.setAttribute("error", "Unsupported file type");
                request.getRequestDispatcher("ProductUploadServlet").forward(request, response);
                return;
            }

            try {
                // Save image temporarily before uploading to Cloudinary
                File tempFile = File.createTempFile("upload_", filePart.getSubmittedFileName());
                try (InputStream inputStream = filePart.getInputStream(); FileOutputStream outputStream = new FileOutputStream(tempFile)) {

                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }
                }

                // Upload to Cloudinary
                Map uploadResult = CloudinaryAPI.getInstance().uploader().upload(tempFile, ObjectUtils.asMap(
                        "resource_type", "image"
                ));
                imageUrl = (String) uploadResult.get("url");
                LOGGER.info("Successfully uploaded file to Cloudinary: " + imageUrl);

                // Delete temporary file
                tempFile.delete();

            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "Error uploading image", e);
                request.setAttribute("errorMessage", "Error uploading image");
                response.sendRedirect("ProductUploadServlet");
                return;
            }
        }

        // Create and save product to the database
        Product product = new Product(0, currentUser.getUser_id(), productName, productDescription, imageUrl, productTag, new Date(), price, quantity);
        productDAO dao = new productDAO();

        try {
            dao.addProduct(product);
            LOGGER.info("Product successfully added for user " + currentUser.getUser_id());
            response.sendRedirect("marketLink");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error saving product to database", e);
            request.setAttribute("errorMessage", "Error saving product");
            request.getRequestDispatcher("ProductUploadServlet").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet handling product uploads with Cloudinary integration";
    }
}
