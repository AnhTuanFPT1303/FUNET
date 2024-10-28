/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import dao.FriendDAO;
import dao.postDAO;
import model.Post;
import model.User;
import java.util.concurrent.TimeUnit;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author bim26
 */
@MultipartConfig
public class postServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
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
            out.println("<title>Servlet postServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet postServlet at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User currentUser = (User) session.getAttribute("user");
            List<Post> posts = postDAO.getAllPosts(currentUser.getUser_id());
            postDAO dao = new postDAO();
            for (Post post : posts) {
                try {
                    post.setLikedByCurrentUser(dao.hasUserLikedPost(currentUser.getUser_id(), post.getPost_id()));
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            request.setAttribute("posts", posts);
            try {
                FriendDAO friendDAO = new FriendDAO();
                List<User> friends = friendDAO.findFriend(currentUser.getUser_id());
                request.setAttribute("friends", friends);
            } catch (Exception e) {
                e.printStackTrace();
            }
            request.getRequestDispatcher("WEB-INF/home.jsp").forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurse
     * @throws IOException if an I/O error occurs
     */
    @Override
     protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            String body = request.getParameter("postContent");
            Part filePart = request.getPart("image");
            String sourceUrl = request.getParameter("sourceUrl");
            String imageUrl = null;

        
            if (filePart != null && filePart.getSize() > 0) {
                try {
                
                    File tempFile = File.createTempFile("upload_", filePart.getSubmittedFileName());
                    
                
                    try (InputStream inputStream = filePart.getInputStream();
                         FileOutputStream outputStream = new FileOutputStream(tempFile)) {
                        byte[] buffer = new byte[1024];
                        int bytesRead;
                        while ((bytesRead = inputStream.read(buffer)) != -1) {
                            outputStream.write(buffer, 0, bytesRead);
                        }
                    }

               
                    Map uploadResult = cloud.uploader().upload(tempFile, ObjectUtils.emptyMap());
                    imageUrl = (String) uploadResult.get("url");

                  
                    Files.deleteIfExists(tempFile.toPath());

                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("errorMessage", "Error uploading image");
                    response.sendRedirect("home");
                    return;
                }
            }

            if (!body.trim().equals("") || imageUrl != null) {
                Post post = new Post();
                post.setUser_id(user.getUser_id());
                post.setBody(body);
                post.setImage_path(imageUrl); 
                postDAO PostDao = new postDAO();
                try {
                    PostDao.addPost(post);

                    TimeUnit.SECONDS.sleep(2);
                    if (sourceUrl != null && sourceUrl.contains("profile")) {
                        response.sendRedirect("profile");
                    } else {
                        response.sendRedirect("home");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("errorMessage", "Error saving post");
                    response.sendRedirect("home");
                }
            } else {
                response.sendRedirect("home");
            }
        } else {
            response.sendRedirect("home");
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
    }
}
