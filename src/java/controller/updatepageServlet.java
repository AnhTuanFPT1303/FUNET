/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.postDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.Post;
import model.User;

/**
 *
 * @author Quocb
 */
@MultipartConfig
public class updatepageServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");

            String postIdParam = request.getParameter("postId");
            String newBody = request.getParameter("newBody");
            Part filePart = request.getPart("newImage");

            try {
                if (postIdParam != null && !postIdParam.isEmpty()) {
                    int postId = Integer.parseInt(postIdParam);
                    Post post = new Post();
                    post.setPost_id(postId);
                    post.setBody(newBody);

                    // Xử lý ảnh mới nếu có
                    if (filePart != null && filePart.getSize() > 0) {
                        String fileName = getSubmittedFileName(filePart);
                        String uploadPath = getServletContext().getRealPath("/") + "assets/profile_avt/" + fileName;
                        filePart.write(uploadPath);
                        post.setImage_path("assets/profile_avt/" + fileName);
                    }

                    postDAO postDao = new postDAO();
                    postDao.updatePost(post);

                    response.setContentType("text/plain");
                    response.getWriter().write("success");
                } else {
                    response.setContentType("text/plain");
                    response.getWriter().write("error: Invalid post ID");
                }
            } catch (Exception e) {
                e.printStackTrace();
                String errorMessage = "Error updating post: " + e.getMessage();
                log(errorMessage);
                response.setContentType("text/plain");
                response.getWriter().write("error: " + errorMessage);
            }
        } else {
            response.setContentType("text/plain");
            response.getWriter().write("error: Invalid session");
        }
    }
// Helper method to get file name from Part

    private String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
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
