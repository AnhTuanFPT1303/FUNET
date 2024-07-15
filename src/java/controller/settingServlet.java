package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import dao.userDAO;
import model.User;

public class settingServlet extends HttpServlet {

    private userDAO userDao;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        userDao = new userDAO();
        String action = request.getParameter("action");

        HttpSession session = request.getSession(false);
        User sessionUser = (User) session.getAttribute("user");

        if (sessionUser == null) {
            // No user in session, redirect to homepage
            response.sendRedirect(request.getContextPath() + "/homepage.jsp?notification=You%20cant%20do%20that");
            return;
        }

        try {
            if (null != action) {
                switch (action) {
                    case "changeInformation" -> {
                        request.getRequestDispatcher("/WEB-INF/setting.jsp").forward(request, response);
                    }
                    case "changeName" -> {
                        String firstName = request.getParameter("firstName");
                        String lastName = request.getParameter("lastName");
                        sessionUser.setFirst_name(firstName);
                        sessionUser.setLast_name(lastName);
                        userDao.updateUser(sessionUser);
                        request.setAttribute("notification", "Your name has been changed to: " + firstName + " " + lastName);
                        request.getRequestDispatcher("/WEB-INF/userpage.jsp").forward(request, response);
                    }
                    case "changePassword" -> {
                        String oldPassword = request.getParameter("oldPassword");
                        String newPassword = request.getParameter("newPassword");
                        String confirmNewPassword = request.getParameter("confirmNewPassword");
                        if (!sessionUser.getPassword().equals(oldPassword)) {
                            request.setAttribute("oldPasswordError", "The old password is incorrect");
                            request.getRequestDispatcher("/WEB-INF/setting.jsp").forward(request, response);
                        } else if (!newPassword.equals(confirmNewPassword)) {
                            request.setAttribute("confirmPasswordError", "Confirm password does not match");
                            request.getRequestDispatcher("/WEB-INF/setting.jsp").forward(request, response);
                        } else {
                            sessionUser.setPassword(newPassword);
                            userDao.updateUser(sessionUser);
                            request.setAttribute("notification", "Your password has been changed successfully. You will be logged out now.");
                            request.getRequestDispatcher("/WEB-INF/userpage.jsp").forward(request, response);
                            session.invalidate();
                            response.sendRedirect(request.getContextPath() + "/login");
                        }
                    }
                }
            }
        } catch (Exception e) {
            // log the error and exception
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        HttpSession session = request.getSession(false);
        User sessionUser = (User) session.getAttribute("user");

        if (sessionUser == null) {
            // No user in session, redirect to homepage
            response.sendRedirect(request.getContextPath() + "/homepage.jsp?notification=You%20cant%20do%20that");
        } else {
            request.getRequestDispatcher("WEB-INF/setting.jsp").forward(request, response);
        }

        // Process the GET request normally
    }
}