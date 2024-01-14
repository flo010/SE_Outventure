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
    public static FacadeJPA facadeJPA = FacadeJPA.getInstance();

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        String hikeCreated = request.getParameter("hikeCreated");
        request.setAttribute("hikeCreated", hikeCreated);

        String hikeDeleted = request.getParameter("hikeDeleted");
        request.setAttribute("hikeDeleted", hikeDeleted);

        String searchString = request.getParameter("search");
        String searchByString = "POI"; //request.getParameter("selectedItem");

        List<Hike> hikeList = null;

        // Retrieve parameters from the URL
        String durationLow = request.getParameter("durationLow");
        String durationHigh = request.getParameter("durationHigh");
        String distanceLow = request.getParameter("distanceLow");
        String distanceHigh = request.getParameter("distanceHigh");
        String altitudeLow = request.getParameter("altitudeLow");
        String altitudeHigh = request.getParameter("altitudeHigh");
        String staminaLow = request.getParameter("staminaLow");
        String staminaHigh = request.getParameter("staminaHigh");
        String powerLow = request.getParameter("powerLow");
        String powerHigh = request.getParameter("powerHigh");
        String experienceLow = request.getParameter("experienceLow");
        String experienceHigh = request.getParameter("experienceHigh");
        String landscapeLow = request.getParameter("landscapeLow");
        String landscapeHigh = request.getParameter("landscapeHigh");
        String month = request.getParameter("month");
        if(durationLow != null){
            hikeList = facadeJPA.search(
                    searchString,
                    Integer.parseInt(durationLow),
                    Integer.parseInt(durationHigh),
                    Integer.parseInt(powerLow),
                    Integer.parseInt(powerHigh),
                    Integer.parseInt(staminaLow),
                    Integer.parseInt(staminaHigh),
                    Integer.parseInt(experienceLow),
                    Integer.parseInt(experienceHigh),
                    Integer.parseInt(landscapeLow),
                    Integer.parseInt(landscapeHigh),
                    Integer.parseInt(distanceLow),
                    Integer.parseInt(distanceHigh),
                    Integer.parseInt(altitudeLow),
                    Integer.parseInt(altitudeHigh),
                    Integer.parseInt(month)
            );
        }
        else if ((searchString != null) && (!searchString.isEmpty())) {
            switch (searchByString){
                case "POI":
                    hikeList = facadeJPA.getPOIByName(searchString).getHikes();
                    break;
                case ("Region") :
                    hikeList = facadeJPA.getRegionByName(searchString).getHikes();
                    break;
                default:
                    hikeList = facadeJPA.getHikesByTitleLazy(searchString);
            }
        } else {
            hikeList = facadeJPA.getAllHikesLazy();
        }

        HttpSession session = request.getSession();
        if (hikeList != null) {
            session.setAttribute("hikeList", hikeList);
            session.setAttribute("searchString", searchString);
        }

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