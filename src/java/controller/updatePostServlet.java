/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import dao.postDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.nio.file.Files;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Post;
import model.User;

/**
 *
 * @author OS
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 100 // 100MB
)
public class updatePostServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(updatePostServlet.class.getName());

    private static final long serialVersionUID = 1L;

    private static final Set<String> ALLOWED_IMAGE_TYPES = new HashSet<>(Arrays.asList(
            "image/jpeg", "image/png", "image/gif", "image/bmp", "image/webp"
    ));

    private static final Set<String> ALLOWED_VIDEO_TYPES = new HashSet<>(Arrays.asList(
            "video/mp4", "video/mpeg", "video/quicktime", "video/x-msvideo", "video/webm"
    ));

    Cloudinary cloud;

    public void init() throws ServletException {
        Properties properties = new Properties();
        String propFileName = "/WEB-INF/cloudinary.properties.txt";
        InputStream inputStream = getServletContext().getResourceAsStream(propFileName);
        if (inputStream == null) {
            throw new ServletException("Property file '" + propFileName + "' not found in classpath");
        }
        try {
            properties.load(inputStream);
        } catch (IOException ex) {
            Logger.getLogger(postServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        String cloudName = properties.getProperty("cloud_name");
        String apiKey = properties.getProperty("api_key");
        String apiSecret = properties.getProperty("api_secret");
        try {
            cloud = new Cloudinary(ObjectUtils.asMap(
                    "cloud_name", cloudName,
                    "api_key", apiKey,
                    "api_secret", apiSecret
            ));
        } catch (Exception e) {
            throw new ServletException("Failed to initialize Cloudinary", e);
        }
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet updatePostServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet updatePostServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            LOGGER.info("Starting to process post update request");
            try {
                String newBody = request.getParameter("newBody");
                Part filePart = request.getPart("newImage");
                int postId = Integer.parseInt(request.getParameter("postId"));
                String resourceType = null;
                if (filePart == null) {
                    LOGGER.warning("No file part found in request");

                }

                postDAO PostDao = new postDAO();
                Post post = PostDao.getPostById(postId);
                LOGGER.log(Level.INFO, "Updating post with ID: {0}", postId);
                if (post == null) {
                    LOGGER.warning("Post not found with ID: " + postId);
                    session.setAttribute("errorMessage", "Post not found");
                    response.sendRedirect("profile");
                    return;
                }

                if (newBody != null && !newBody.trim().isEmpty()) {
                    post.setBody(newBody);
                }

                if (filePart != null && filePart.getSize() > 0) {
                    String contentType = filePart.getContentType();
                    LOGGER.info("File upload detected with content type: " + contentType);
                    if (!ALLOWED_IMAGE_TYPES.contains(contentType) && !ALLOWED_VIDEO_TYPES.contains(contentType)) {
                        LOGGER.warning("Unsupported file type attempted: " + contentType);
                        request.setAttribute("error", "Unsupported file type");
                        response.sendRedirect("profile");
                        return;
                    }
                    resourceType = ALLOWED_IMAGE_TYPES.contains(contentType) ? "image" : "video";
                    try {
                        LOGGER.info("Starting file upload process");
                        File tempFile = File.createTempFile("upload_", filePart.getSubmittedFileName());

                        try (InputStream inputStream = filePart.getInputStream(); FileOutputStream outputStream = new FileOutputStream(tempFile)) {
                            byte[] buffer = new byte[8192];
                            int bytesRead;
                            while ((bytesRead = inputStream.read(buffer)) != -1) {
                                outputStream.write(buffer, 0, bytesRead);
                            }
                        }

                        Map uploadResult = cloud.uploader().upload(tempFile, ObjectUtils.asMap(
                                "resource_type", resourceType
                        ));
                        String imageUrl = (String) uploadResult.get("url");
                        post.setImage_path(imageUrl);
                        post.setType(resourceType);
                        LOGGER.info("File upload with type "+ resourceType);
                        LOGGER.info("File uploaded successfully to Cloudinary");
                        Files.deleteIfExists(tempFile.toPath());
                    } catch (Exception e) {
                        LOGGER.log(Level.SEVERE, "Error uploading file", e);
                        e.printStackTrace();
                        session.setAttribute("errorMessage", "Error uploading image");
                        //response.sendRedirect("profile");
                        return;
                    }
                }

                PostDao.updatePost(post);
                session.setAttribute("successMessage", "Post updated successfully");
                LOGGER.info("Post updated successfully");
                response.setContentType("text/plain");
                response.getWriter().write("success");
                // response.sendRedirect("profile");

            } catch (Exception e) {
                e.printStackTrace();
                LOGGER.log(Level.SEVERE, "Error in doPost method", e);
                session.setAttribute("errorMessage", "Error updating post: " + e.getMessage());
                response.setContentType("text/plain");
                response.getWriter().write("error: Invalid post ID");
                // response.sendRedirect("profile");
            }
        } else {
            response.sendRedirect("profile");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
