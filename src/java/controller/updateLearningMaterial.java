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
import java.util.Date;
import model.LearningMaterial;
import model.User;

/**
 *
 * @author gabri
 */
public class updateLearningMaterial extends HttpServlet {
   
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
            out.println("<title>Servlet updateLearningMaterial</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet updateLearningMaterial at " + request.getContextPath () + "</h1>");
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
        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String subjectCode = request.getParameter("subjectCode");
        String departmentIdStr = request.getParameter("departmentId");
        String imgFileName = request.getParameter("img");
        String contextFileName = request.getParameter("context");
        String review = request.getParameter("review");

        if (idStr == null || name == null || description == null || subjectCode == null || departmentIdStr == null || imgFileName == null || contextFileName == null || review == null) {
            response.sendRedirect("lmaterialLink");
            return;
        }

        int id;
        int departmentId;
        try {
            id = Integer.parseInt(idStr);
            departmentId = Integer.parseInt(departmentIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("lmaterialLink");
            return;
        }

        learningMaterialDao learningMaterialDao = new learningMaterialDao();
        try {
            LearningMaterial lm = learningMaterialDao.getLearningMaterialById(id);
            if (lm != null && lm.getUserId() == user.getUser_id()) {
                String imgPath = "assets/learningMaterial/" + imgFileName;
                String contextPath = "assets/product/" + contextFileName;

                LearningMaterial l = new LearningMaterial(id, user.getUser_id(), name, description, contextPath, subjectCode, new Date(), review, departmentId);
                learningMaterialDao.updateLearningMaterial(l);
                request.setAttribute("successMessage", "Learning Material updated successfully");
            } else {
                request.setAttribute("errorMessage", "You do not have permission to update this learning material");
            }
            response.sendRedirect("lmaterialLink");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error updating learning material");
            response.sendRedirect("lmaterialLink");
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
