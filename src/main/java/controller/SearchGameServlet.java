package controller;

import dao.SearchGameDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.game;

@WebServlet("/searchGame")
public class SearchGameServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        SearchGameDAO searchdao = new SearchGameDAO();
        List<game> list = searchdao.searchGameByKeyword(keyword);

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        if (list.isEmpty()) {
            out.println("<div class='flex items-center justify-center p-4 border border-gray-300 rounded-lg bg-white shadow-md'>"
                    + "<div class='text-center'>"
                    + "<p class='text-lg font-medium text-gray-800'>Result not found</p>"
                    + "</div>"
                    + "</div>");
        } else {
            for (game sanPham : list) {
                out.println("<div class='flex items-center space-x-4 p-2 border-b border-gray-200 hover:bg-gray-100 cursor-pointer w-full'"
                        + " onclick=\"showGame('" + sanPham.getLink() + "')\">"
                        + "<img src='" + sanPham.getLinkimg() + "' alt='" + sanPham.getTengame() + "' class='w-16 h-16 object-cover rounded-lg'>"
                        + "<div class='flex flex-col'>"
                        + "<h4 class='text-lg font-medium text-gray-800'>" + sanPham.getTengame() + "</h4>"
                        + "<p class='text-sm text-gray-500'>" + sanPham.getTheloai() + "</p>"
                        + "</div>"
                        + "</div>");
            }
        }
        out.close();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Do nothing for POST requests
    }

    @Override
    public String getServletInfo() {
        return "SearchGameServlet handles game search requests";
    }
}
