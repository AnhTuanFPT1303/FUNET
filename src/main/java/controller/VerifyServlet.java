/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.userDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import jakarta.servlet.http.HttpSession;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.SmtpProtocol;

/**
 *
 * @author HELLO
 */
public class VerifyServlet extends HttpServlet {

    private userDAO userDao = userDAO.getInstance();    
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
            out.println("<title>Servlet VerifyServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerifyServlet at " + request.getContextPath() + "</h1>");
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

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String act = request.getParameter("action");
        HttpSession session = request.getSession(false);
        String otp = (String) session.getAttribute("otpCode");
        String email = (String) session.getAttribute("pendingEmail");
        System.out.println(otp);
        if ("resend".equals(act)) {
            SmtpProtocol smtpProtocol = new SmtpProtocol();
            otp = Integer.toString(smtpProtocol.sendMail(email));
            session.setAttribute("otpCode", otp);
            request.getRequestDispatcher("WEB-INF/verify.jsp").forward(request, response);
        } else {
            String inputOtp = (String) request.getParameter("otp-code");
            if (otp.equals(inputOtp)) {
                if (act.equals("newPass")) {
                    request.getRequestDispatcher("WEB-INF/newPassword.jsp").forward(request, response);
                } else {
                    Map<String, String> pendingUserInfo = (Map<String, String>) session.getAttribute("pendingUserInfo");
                    User user = new User();
                    user.setEmail(email);
                    user.setFirst_name(pendingUserInfo.get("firstName"));
                    user.setLast_name(pendingUserInfo.get("lastName"));
                    user.setPassword(pendingUserInfo.get("password"));
                    user.setProfile_pic("default_avt.jpg");
                    user.setRole("student");
                    user.setStatus(false);
                    try {
                        userDao.register(user);
                    } catch (Exception ex) {
                        Logger.getLogger(VerifyServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    // Clean up session
                    session.invalidate();
                    request.getRequestDispatcher("WEB-INF/login.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("msg", "Invalid OTP. Please try again.");
                request.getRequestDispatcher("WEB-INF/verify.jsp").forward(request, response);
            }
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
