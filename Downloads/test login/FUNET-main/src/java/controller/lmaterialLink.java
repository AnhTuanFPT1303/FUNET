package controller;

import dao.learningMaterialDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.LearningMaterial;

public class lmaterialLink extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        learningMaterialDao learnMaterialDao = new learningMaterialDao();

        List<LearningMaterial> learningMaterialsList = null;
        try {
            learningMaterialsList = learnMaterialDao.getAll();
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        request.setAttribute("learningMaterialsList", learningMaterialsList);

        request.getRequestDispatcher("WEB-INF/LearningMaterial.jsp").forward(request, response);
        // chuyển hướng đến lmaterial.jsp
    }
}