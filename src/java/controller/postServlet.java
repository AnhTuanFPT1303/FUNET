/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;
import dao.postDAO;
import model.Post;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author bim26
 */
@MultipartConfig
public class postServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

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
        //like fichua
       String pathInfo = request.getPathInfo();
        if (pathInfo != null && pathInfo.startsWith("/")) {
            String[] pathParts = pathInfo.split("/");
            if (pathParts.length == 3) {
                int postId = Integer.parseInt(pathParts[1]);
                String action = pathParts[2];
                
                if (session != null && session.getAttribute("user") != null) {
                    User currentUser = (User) session.getAttribute("user");
                    int userId = currentUser.getUser_id();
                    
                    postDAO dao = new postDAO();
                    try {
                        if ("like".equals(action)) {
                            dao.addLike(userId, postId);
                        } else if ("unlike".equals(action)) {
                            dao.removeLike(userId, postId);
                        }
                        
                        int newLikeCount = dao.getLikeCount(postId);
                        response.setContentType("application/json");
                        response.getWriter().write("{\"like_count\":" + newLikeCount + "}");
                        return;
                    } catch (SQLException e) {
                        e.printStackTrace();
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        return;
                    }
                }
            }
        }

    
        
    // ------------------------------------------------------------------------------------------------- 

    
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            String body = request.getParameter("postContent");

            Part file = request.getPart("image");
            String image_path = file.getSubmittedFileName();
            String uploadPath = "E:/blahproject/BLAH/web/assets/post_image/" + image_path;
            //E:\blahproject\BLAH\web\assets
            try {
                FileOutputStream fos = new FileOutputStream(uploadPath);
                InputStream is = file.getInputStream();

                byte[] data = new byte[is.available()];
                is.read(data);
                fos.write(data);
                fos.close();
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (!body.trim().equals("") || !image_path.equals("")) {
                Post post = new Post();
                post.setUser_id(user.getUser_id());
                post.setBody(body);
                post.setImage_path(image_path);
                postDAO PostDao = new postDAO();
                try {
                    PostDao.addPost(post);
                    response.sendRedirect("home");
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("errorMessage", "Error saving post");
                    response.sendRedirect("home");
                }
            }
            else {
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
