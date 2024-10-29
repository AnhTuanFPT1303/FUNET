/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.ConversationDAO;
import dao.userDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import model.Conversation;
import dtos.ConversationDTO;
import dtos.MessageDTO;
import dtos.UserDTO;
import services.ConversationService;

/**
 *
 * @author HELLO
 */
public class ConversationRestController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ConversationRestController.class.getName());

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
            out.println("<title>Servlet ConversationRestController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ConversationRestController at " + request.getContextPath() + "</h1>");
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
        String usersConversationId = request.getParameter("usersConversationId");
        String messagesConversationId = request.getParameter("messagesConversationId");
        String conversationKeyword = request.getParameter("conversationKeyword");
        String json = "";

        ConversationService conversationService = ConversationService.getInstance();
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            if (conversationKeyword != null && !conversationKeyword.isEmpty() && user_id != null && !user_id.isEmpty()) {
                LOGGER.info("Fetching conversations by keyword for user");
                List<ConversationDTO> conversationDTOs = conversationService
                        .getConversationsOfUserByKeyword(Integer.parseInt(user_id), conversationKeyword);
                for (ConversationDTO c : conversationDTOs) {
                    List<UserDTO> userDTOs = conversationService.getAllUsersByConversationId(c.getId()).stream()
                            .filter(u -> u.isIsAdmin()).collect(Collectors.toList());
                    c.setUsers(userDTOs);
                }
                json = objectMapper.writeValueAsString(conversationDTOs);

            } else if (user_id != null) {
                List<ConversationDTO> conversationDTOs = conversationService
                        .getAllConversationsById(Integer.parseInt(user_id));
                for (ConversationDTO conversationDTO : conversationDTOs) {
                    conversationDTO.setUsers(conversationService.getAllUsersByConversationId(conversationDTO.getId()));
                }
                json = objectMapper.writeValueAsString(conversationDTOs);
            } else if (usersConversationId != null && !usersConversationId.isEmpty()) {
                LOGGER.info("Fetch go here");
                int id = Integer.parseInt(usersConversationId);
                List<UserDTO> userDTOs = conversationService.getAllUsersByConversationId(id);
                json = objectMapper.writeValueAsString(userDTOs);

            } else if (messagesConversationId != null && !messagesConversationId.isEmpty()) {

                int id = Integer.parseInt(messagesConversationId);
                List<MessageDTO> messageDTOs = conversationService.getAllMessagesByConversationId(id);

                json = objectMapper.writeValueAsString(messageDTOs);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

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
        ConversationService conversationService = ConversationService.getInstance();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter printWriter = response.getWriter();
        String json = "";

        StringBuilder requestBody = new StringBuilder();
        String line = null;
        try {
            BufferedReader reader = request.getReader();
            while ((line = reader.readLine()) != null) {
                requestBody.append(line);
                Logger.getLogger(ConversationRestController.class.getName()).info(line);
            }
        } catch (IOException ex) {
            json = "{\"error\":\"" + ex.getMessage() + "\"}";
            printWriter.print(json);
            printWriter.flush();
            return;
        }
        LOGGER.info(requestBody.toString());

        ObjectMapper objectMapper = new ObjectMapper();
        ConversationDTO conversation = objectMapper.readValue(requestBody.toString(), ConversationDTO.class);
        try {
            conversationService.saveConversation(conversation);
        } catch (Exception ex) {
            Logger.getLogger(ConversationRestController.class.getName()).log(Level.SEVERE, null, ex);
        }
        json = objectMapper.writeValueAsString(conversation);
        printWriter.print(json);
        printWriter.flush();
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String user_id = request.getParameter("user_id");
        String conversationId = request.getParameter("conversationId");
        String json = "Must have userId or conversation id as request param";
        if (conversationId != null && !conversationId.isEmpty()) {
            int id = Integer.parseInt(conversationId);
            if (user_id != null && !user_id.isEmpty()) {
                try {
                    ConversationService.getInstance().deleteUserFromConversation(id, Integer.parseInt(user_id));
                } catch (Exception ex) {
                    Logger.getLogger(ConversationRestController.class.getName()).log(Level.SEVERE, null, ex);
                }
                json = "delete User by Id " + user_id + " From Conversation by Id " + id + " successfully";
            } else {
                try {
                    ConversationService.getInstance().deleteConversationById(id);
                } catch (Exception ex) {
                    Logger.getLogger(ConversationRestController.class.getName()).log(Level.SEVERE, null, ex);
                }
                json = "delete Conversation By Id " + id + " successfully";
            }
        }
        ObjectMapper objectMapper = new ObjectMapper();
        json = objectMapper.writeValueAsString(json);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter printWriter = response.getWriter();
        printWriter.print(json);
        printWriter.flush();
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
