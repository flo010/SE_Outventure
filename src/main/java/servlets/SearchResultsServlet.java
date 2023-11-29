package servlets;

import java.io.*;
import java.util.List;

import hibernate.facade.FacadeJPA;
import hibernate.model.Hike;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "searchResultsServlet", value = "/search_results")
public class SearchResultsServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        String hikeCreated = request.getParameter("hikeCreated");
        request.setAttribute("hikeCreated", hikeCreated);

        String hikeDeleted = request.getParameter("hikeDeleted");
        request.setAttribute("hikeDeleted", hikeDeleted);

        FacadeJPA facadeJPA = FacadeJPA.getInstance();
        String title = request.getParameter("search");
        List<Hike> hikeList = null;

        if (title != null && !title.isEmpty()) {
            hikeList = facadeJPA.getHikesByTitleLazy(title);
        } else {
            hikeList = facadeJPA.getAllHikesLazy();
        }

        HttpSession session = request.getSession();
        session.setAttribute("hikeList", hikeList);

        request.setAttribute("hikeList", hikeList);

        try {
            request.getRequestDispatcher("/search_results.jsp").forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }
}