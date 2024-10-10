package controller;

import dao.FriendDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.User;

public class ContactToSellerServlet extends HttpServlet {
    //Chuyển hướng đến chat của người bán
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {      
        try{
            User currentUser = (User) request.getSession(false).getAttribute("user");
            FriendDAO friendDAO = new FriendDAO();
            List<User> friends = friendDAO.findFriend(currentUser.getUser_id());
            
            request.setAttribute("friends", friends);
            request.setAttribute("user", currentUser);
            
            request.getRequestDispatcher("WEB-INF/chatbox.jsp").forward(request, response);
        } catch (Exception exception){
            exception.printStackTrace();
        }
    }
}
