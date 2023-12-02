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
        String searchString = request.getParameter("search");

        List<Hike> hikeList = null;

        if ((searchString != null) && (!searchString.isEmpty())) {
            hikeList = facadeJPA.getHikesByTitleLazy(searchString);
        } else {
            hikeList = facadeJPA.getAllHikesLazy();
        }

        HttpSession session = request.getSession();
        session.setAttribute("hikeList", hikeList);
        session.setAttribute("searchString", searchString);

        try {
            request.getRequestDispatcher("/search_results/search_results.jsp").forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String clearedSearchString = request.getParameter("clearedSearchString");

        if (clearedSearchString != null) {
            HttpSession session = request.getSession();
            session.setAttribute("searchString", clearedSearchString);
        }
    }
}