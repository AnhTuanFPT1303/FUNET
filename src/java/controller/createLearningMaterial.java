/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.learningMaterialDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Collection;
import model.LearningMaterial;
import model.User;

/**
 *
 * @author gabri
 */
public class createLearningMaterial extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet createLearningMaterial</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet createLearningMaterial at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String subjectCode = request.getParameter("subjectCode");
            String departmentIdStr = request.getParameter("departmentId");
            String imgFileName = request.getParameter("img");
            String contextFileName = request.getParameter("context");

            if (name == null || description == null || subjectCode == null || departmentIdStr == null || imgFileName == null || contextFileName == null) {
                response.sendRedirect("WEB-INF/LearningMaterial.jsp");
                return;
            }

            int departmentId;
            try {
                departmentId = Integer.parseInt(departmentIdStr);
            } catch (NumberFormatException e) {
                response.sendRedirect("WEB-INF/LearningMaterial.jsp");
                return;
            }

            String imgPath = "assets/learningMaterial/" + imgFileName;
            String contextPath = "assets/learningMaterial/" + contextFileName;

            LearningMaterial learningMaterial = new LearningMaterial(0, user.getUser_id(), name, description, imgPath, contextPath, subjectCode, new java.util.Date(), "", departmentId);
            learningMaterialDao learningMaterialDao = new learningMaterialDao();
            try {
                learningMaterialDao.addLearningMaterial(learningMaterial);
                request.setAttribute("WEB-INF/successMessage", "Learning Material created successfully");
                response.sendRedirect("WEB-INF/LearningMaterial.jsp");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Error saving learning material");
                request.getRequestDispatcher("WEB-INF/LearningMaterial.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("WEB-INF/login.jsp");
        }
    }



    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
