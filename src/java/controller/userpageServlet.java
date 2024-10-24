package controller;

import dao.FriendDAO;
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
import model.Comment;
import model.Post;
import model.User;

@MultipartConfig
public class userpageServlet extends HttpServlet {

    private userDAO userDao = userDAO.getInstance();    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("user");
        String userIdParam = request.getParameter("userId");
        int userId;

        if (userIdParam != null && !userIdParam.isEmpty()) {
            try {
                userId = Integer.parseInt(userIdParam);
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid user ID provided");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }
        } else {
            userId = currentUser.getUser_id();
        }

        User user;
        try {
            user = userDao.getUserById(userId);
            if (user == null) {
                request.setAttribute("errorMessage", "User not found");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }
            String introduction = userDao.getUserIntroduce(user.getUser_id());
            user.setUser_introduce(introduction);
        } catch (SQLException ex) {
            Logger.getLogger(userpageServlet.class.getName()).log(Level.SEVERE, "Error fetching user", ex);
            request.setAttribute("errorMessage", "Error fetching user data");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        postDAO postDAO = new postDAO();
        List<Post> posts;
        try {
            posts = postDAO.getMyPosts(user.getUser_id());
            for (Post post : posts) {
                List<Comment> comments = postDAO.getComments(post.getPost_id());
                post.setComments(comments);
            }
        } catch (Exception e) {
            Logger.getLogger(userpageServlet.class.getName()).log(Level.SEVERE, "Error fetching posts", e);
            request.setAttribute("errorMessage", "Error fetching posts");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        try {
            FriendDAO friendDAO = new FriendDAO();
            List<User> friends = friendDAO.findFriend(user.getUser_id());
            int friendCount = friendDAO.friendCount(user.getUser_id());
            request.setAttribute("friends", friends);
            request.setAttribute("friendCount", friendCount);
        } catch (Exception e) {
            Logger.getLogger(userpageServlet.class.getName()).log(Level.SEVERE, "Error fetching friends", e);

        }

        request.setAttribute("user", user);
        request.setAttribute("posts", posts);
        request.getRequestDispatcher("/WEB-INF/profile.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            String body = request.getParameter("postContent");

            Part file = request.getPart("image");
            String image_path = file.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("/assets/post_image/") + image_path;
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
                    response.sendRedirect("profile");
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("errorMessage", "Error saving post");
                    response.sendRedirect("profile");
                }
            } else {
                response.sendRedirect("profile");
            }
        } else {
            response.sendRedirect("profile");
        }
    }
}
