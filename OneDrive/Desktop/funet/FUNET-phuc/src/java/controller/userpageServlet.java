package controller;

import dao.postDAO;
import dao.userDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Post;
import model.User;


@MultipartConfig
public class userpageServlet extends HttpServlet {

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
                    response.sendRedirect("userpageServlet");
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("errorMessage", "Error saving post");
                    response.sendRedirect("userpageServlet");
                }
            }
            else {
                response.sendRedirect("userpageServlet");
            }
        } else {
            response.sendRedirect("userpageServlet");  
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String userIdParam = req.getParameter("userId");
        int userId = currentUser.getUser_id();

        if (userIdParam != null && !userIdParam.isEmpty()) {
            try {
                userId = Integer.parseInt(userIdParam);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        userDAO userDAO = new userDAO();
        User user = new User();
        try {
            user = userDAO.getUserById(userId); // Get user details by userId
        } catch (SQLException ex) {
            Logger.getLogger(userpageServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        postDAO postDAO = new postDAO();
        List<Post> posts = null;
        try {
            posts = postDAO.getMyPosts(user.getUser_id()); // Get posts of the specified user
        } catch (Exception e) {
            e.printStackTrace();
        }

        req.setAttribute("user", user); // Set the user object as an attribute
        req.setAttribute("posts", posts); // Set the posts list as an attribute
        req.getRequestDispatcher("/WEB-INF/userpage.jsp").forward(req, resp);
    }
    
    
}
