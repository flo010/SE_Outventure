package servlets;

import hibernate.facade.FacadeJPA;
import hibernate.model.Destination;
import hibernate.model.Hike;
import hibernate.model.Start;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;

import java.io.IOException;

@WebServlet(name = "saveDataServlet", value = "/save_data")
public class SaveDataServlet extends HttpServlet {
    @Transactional
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        String title = request.getParameter("titleInput");
        String description = request.getParameter("descriptionInput");
        double distance = Double.parseDouble(request.getParameter("distanceInput"));;
        int hours = Integer.parseInt(request.getParameter("hoursInput"));
        int minutes = Integer.parseInt(request.getParameter("minutesInput"));
        double duration = hours + (minutes / 60.0);
        int altitude = Integer.parseInt(request.getParameter("altitudeInput"));;

        Start start = new Start();
        start.setName("Start Lea");
        start.setLatitude(40.12);
        start.setLongitude(10.2);

        Destination destination = new Destination();
        destination.setName("Destination Lea");
        destination.setLatitude(42.12);
        destination.setLongitude(10.12);

        int strength = Integer.parseInt(request.getParameter("difficultyInput"));;
        int stamina = Integer.parseInt(request.getParameter("conditionInput"));
        int experience = Integer.parseInt(request.getParameter("experienceInput"));;
        int landscape = Integer.parseInt(request.getParameter("landscapeInput"));;
        boolean january = Boolean.parseBoolean(request.getParameter("monthCheckboxJanuary"));
        boolean february = Boolean.parseBoolean(request.getParameter("monthCheckboxFebruary"));
        boolean march = Boolean.parseBoolean(request.getParameter("monthCheckboxMarch"));
        boolean april = Boolean.parseBoolean(request.getParameter("monthCheckboxApril"));
        boolean may = Boolean.parseBoolean(request.getParameter("monthCheckboxMay"));
        boolean june = Boolean.parseBoolean(request.getParameter("monthCheckboxJune"));
        boolean july = Boolean.parseBoolean(request.getParameter("monthCheckboxJuly"));
        boolean august = Boolean.parseBoolean(request.getParameter("monthCheckboxAugust"));
        boolean september = Boolean.parseBoolean(request.getParameter("monthCheckboxSeptember"));
        boolean october = Boolean.parseBoolean(request.getParameter("monthCheckboxOctober"));
        boolean november = Boolean.parseBoolean(request.getParameter("monthCheckboxNovember"));
        boolean december = Boolean.parseBoolean(request.getParameter("monthCheckboxDecember"));
        String routeDescription = request.getParameter("RouteDescriptionInput");

        System.out.println("Recieved Data");
        Hike hike = new Hike();
//        hike.setHikeID(hikeId);
        hike.setTitle(title);
        hike.setDescription(description);
        hike.setDuration(duration);
        hike.setDistance(distance);
        hike.setAltitude(altitude);
        hike.setStart(start);
        hike.setDestination(destination);
        hike.setStrength(strength);
        hike.setStamina(stamina);
        hike.setExperience(experience);
        hike.setLandscape(landscape);
        hike.setJanuary(january);
        hike.setFebruary(february);
        hike.setMarch(march);
        hike.setApril(april);
        hike.setMay(may);
        hike.setJune(june);
        hike.setJuly(july);
        hike.setAugust(august);
        hike.setSeptember(september);
        hike.setOctober(october);
        hike.setNovember(november);
        hike.setDecember(december);
        hike.setRouteDescription(routeDescription);
        System.out.println("Data Saved Locally");
        FacadeJPA facadeJPA = FacadeJPA.getInstance();
        facadeJPA.save(hike);
        System.out.println("Data Save on Server");
        response.sendRedirect("search_results?hikeCreated=true");
    }
}
