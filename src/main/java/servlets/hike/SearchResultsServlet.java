package servlets.hike;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

import hibernate.facade.FacadeJPA;
import hibernate.model.Hike;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "searchResultsServlet", value = "/search_results")
public class SearchResultsServlet extends HttpServlet {
    public static FacadeJPA facadeJPA = FacadeJPA.getInstance();

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");

        String hikeCreated = request.getParameter("hikeCreated");
        request.setAttribute("hikeCreated", hikeCreated);

        String hikeDeleted = request.getParameter("hikeDeleted");
        request.setAttribute("hikeDeleted", hikeDeleted);

        String searchString = request.getParameter("search");
        String selectedSearchItem = request.getParameter("selectedSearchItem");

        List<Hike> hikeList;
        List<Hike> hikeList0 = new ArrayList<>();
        List<Hike> hikeList1;
        List<Hike> hikeList2;
        List<Hike> hikeList3;

        // Retrieve parameters from the URL
        String durationLow = request.getParameter("durationLow");
        String durationHigh = request.getParameter("durationHigh");
        String distanceLow = request.getParameter("distanceLow");
        String distanceHigh = request.getParameter("distanceHigh");
        String altitudeLow = request.getParameter("altitudeLow");
        String altitudeHigh = request.getParameter("altitudeHigh");
        String staminaLow = request.getParameter("staminaLow");
        String staminaHigh = request.getParameter("staminaHigh");
        String powerLow = request.getParameter("strengthLow");
        String powerHigh = request.getParameter("strengthHigh");
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
            switch (selectedSearchItem){
                case ("Title"):
                    hikeList = facadeJPA.getHikesByTitleLazy(searchString);
                    break;
                case "POI":
                    hikeList = facadeJPA.getPOIByName(searchString);
                    break;
                case ("Region") :
                    hikeList = facadeJPA.getHikesByRegionByName(searchString);
                    break;
                default:
                    hikeList1 = facadeJPA.getHikesByTitleLazy(searchString);
                    hikeList2 = facadeJPA.getHikesByRegionByName(searchString);
                    hikeList3 = facadeJPA.getPOIByName(searchString);

                    boolean notexists = true;
                    for (Hike hike: hikeList1) {
                        if (hikeList0.isEmpty()){
                            hikeList0.add(hike);
                        }else {
                            for (Hike value : hikeList0) {
                                if (hike.getHikeID() == value.getHikeID()) {
                                    notexists = false;
                                    break;
                                }
                            }
                            if (notexists){
                                hikeList0.add(hike);
                            }
                        }
                    }
                    for (Hike hike: hikeList2) {
                        notexists = true;
                        if (hikeList0.isEmpty()){
                            hikeList0.add(hike);
                        }else {
                            for (Hike value : hikeList0) {
                                if (hike.getHikeID() == value.getHikeID()) {
                                    notexists = false;
                                    break;
                                }
                            }
                            if (notexists){
                                hikeList0.add(hike);
                            }
                        }
                    }
                    for (Hike hike: hikeList3) {
                        notexists = true;
                        if (hikeList0.isEmpty()){
                            hikeList0.add(hike);
                        }else {
                            for (Hike value : hikeList0) {
                                if (hike.getHikeID() == value.getHikeID()) {
                                    notexists = false;
                                    break;
                                }
                            }
                            if (notexists){
                                hikeList0.add(hike);
                            }
                        }
                    }
                    hikeList = hikeList0;
            }
        } else {
            hikeList = facadeJPA.getAllHikesLazy();
        }

        HttpSession session = request.getSession();
        if (hikeList != null) {
            session.setAttribute("hikeList", hikeList);
            session.setAttribute("searchString", searchString);
            session.setAttribute("selectedSearchItem", selectedSearchItem);
        }
        request.getRequestDispatcher("/hike/search_results/search_results.jsp").forward(request, response);
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        String clearedSearchString = request.getParameter("clearedSearchString");

        if (clearedSearchString != null) {
            HttpSession session = request.getSession();
            session.setAttribute("searchString", clearedSearchString);
        }
    }
}