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

        FacadeJPA facadeJPA = FacadeJPA.getInstance();
        List<Hike> hikeList = facadeJPA.getAllHikesLazy();

        request.setAttribute("hikeList", hikeList);

        try {
            request.getRequestDispatcher("/search_results.jsp").forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }
}