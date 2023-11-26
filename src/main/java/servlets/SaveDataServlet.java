package servlets;

import hibernate.facade.FacadeJPA;
import hibernate.model.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "saveDataServlet", value = "/save_data")
public class SaveDataServlet extends HttpServlet {
    @Transactional
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        String title = request.getParameter("titleInput");
        String description = request.getParameter("descriptionInput");
        double distance = Double.parseDouble(request.getParameter("distanceInput"));
        int hours = Integer.parseInt(request.getParameter("hoursInput"));
        int minutes = Integer.parseInt(request.getParameter("minutesInput"));
        double duration = hours + (minutes / 60.0);
        int altitude = Integer.parseInt(request.getParameter("altitudeInput"));


        Start start = new Start();
        start.setStartID(1);
        start.setName("Start Lea");
        start.setLatitude(40.12);
        start.setLongitude(10.2);

        Destination destination = new Destination();
        destination.setDestinationID(1);
        destination.setName("Destination Lea");
        destination.setLatitude(42.12);
        destination.setLongitude(10.12);

        int strength = Integer.parseInt(request.getParameter("difficultyInput"));
        int stamina = Integer.parseInt(request.getParameter("conditionInput"));
        int experience = Integer.parseInt(request.getParameter("experienceInput"));
        int landscape = Integer.parseInt(request.getParameter("landscapeInput"));
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
        String routeDescription = request.getParameter("routeDescriptionInput");
        String arrivalInformation = request.getParameter("gettingThereInput");
        String parkingInformation = request.getParameter("parkingInput");
        LocalDate currentDate = LocalDate.now();
        String[] poiNames = request.getParameterValues("poiNameInput");
        String[] poiLatitudes = request.getParameterValues("poiLatitudeInput");
        String[] poiLongitudes = request.getParameterValues("poiLongitudeInput");
        String[] poiDescriptions = request.getParameterValues("poiDescriptionInput");


        Hike hike = new Hike();

        List<PointOfInterest> pointsOfInterest = new ArrayList<>();

        if(poiNames != null) {
            for (int i = 0; i < poiNames.length; i++) {
                PointOfInterest pointOfInterest = new PointOfInterest();
                pointOfInterest.setName(poiNames[i]);
                pointOfInterest.setLatitude(Double.parseDouble(poiLatitudes[i]));
                pointOfInterest.setLongitude(Double.parseDouble(poiLongitudes[i]));
                pointOfInterest.setDescription(poiDescriptions[i]);
                pointOfInterest.setHikePOI(hike);
                pointsOfInterest.add(pointOfInterest);
            }
        }

        hike.setPointsOfInterest(pointsOfInterest);

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
        if (!arrivalInformation.isEmpty()) {
            hike.setArrivalInformation(arrivalInformation);
        }
        if (!parkingInformation.isEmpty()) {
            hike.setParkingInformation(parkingInformation);
        }
        hike.setAuthor("Admin");
        hike.setDate(currentDate);
        hike.setVisible(true);
        FacadeJPA facadeJPA = FacadeJPA.getInstance();
        try {
            Thread.sleep(4 * 1000);
        } catch (InterruptedException ie) {
            Thread.currentThread().interrupt();
        }
        Picture picture = facadeJPA.getNewPicture();
        picture.setSet(false);
        hike.setPreviewPicture(picture.getPictureID());
        facadeJPA.save(picture);
        facadeJPA.save(hike);

        response.sendRedirect("search_results?hikeCreated=true");
    }
}
