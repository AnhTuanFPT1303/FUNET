/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.userDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;
import services.ChatService;

/**
 *
 * @author HELLO
 */
public class UserRestController extends HttpServlet {

    private ChatService chatService = ChatService.getInstance();

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
            out.println("<title>Servlet UserRestController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserRestController at " + request.getContextPath() + "</h1>");
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
        String user_id = request.getParameter("user_id");
        String keyWord = request.getParameter("keyword");
        String conversationId = request.getParameter("conversationId");
        List<User> listUsers = null;
        if (conversationId != null && !conversationId.isEmpty()) {
            int id = Integer.parseInt(conversationId);
            try {
                listUsers = userDAO.getInstance().getFriendsNotInConversation(Integer.parseInt(user_id), keyWord, id);
                Logger.getLogger(UserRestController.class.getName()).info("will it be here1");
            } catch (Exception ex) {
                Logger.getLogger(UserRestController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (keyWord.isEmpty()) {
            try {
                listUsers = userDAO.getInstance().getUserFriends(Integer.parseInt(user_id));
                Logger.getLogger(UserRestController.class.getName()).info("will it be here2");
            } catch (Exception ex) {
                Logger.getLogger(UserRestController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            try {
                listUsers = userDAO.getInstance().findFriendsByKeyWord(Integer.parseInt(user_id), keyWord);
                Logger.getLogger(UserRestController.class.getName()).info("will it be here3");
            } catch (Exception ex) {
                Logger.getLogger(UserRestController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        ObjectMapper objectMapper = new ObjectMapper();
        String json = objectMapper.writeValueAsString(listUsers);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter printWriter = response.getWriter();
        printWriter.print(json);
        printWriter.flush();
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
        processRequest(request, response);
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
