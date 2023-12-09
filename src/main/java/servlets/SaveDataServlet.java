package servlets;

import hibernate.facade.FacadeJPA;
import hibernate.model.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "saveDataServlet", value = "/save_data")
public class SaveDataServlet extends HttpServlet {

    @Transactional
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        saveToDatabase(request,response);

        int hikeID = Integer.parseInt(request.getParameter("hikeID"));
        response.sendRedirect("hike_detail?id=" + hikeID + "&hikeEdited=true");
    }

    @Transactional
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        saveToDatabase(request, response);
        response.sendRedirect("/search_results?hikeCreated=true");
    }

    private void saveToDatabase(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String title = request.getParameter("titleInput");
        String description = request.getParameter("descriptionInput");
        double distance = Double.parseDouble(request.getParameter("distanceInput"));
        int hours = Integer.parseInt(request.getParameter("hoursInput"));
        int minutes = Integer.parseInt(request.getParameter("minutesInput"));
        double duration = hours + (minutes / 60.0);
        int altitude = Integer.parseInt(request.getParameter("altitudeInput"));

        String startName = request.getParameter("startNameInput");
        double startLatitude = Double.parseDouble(request.getParameter("latitudeStartCoordinateInput"));
        double startLongitude = Double.parseDouble(request.getParameter("longitudeStartCoordinateInput"));
        Start start = new Start();
        start.setName(startName);
        start.setLatitude(startLatitude);
        start.setLongitude(startLongitude);

        String destinationName = request.getParameter("destinationNameInput");
        double destinationLatitude = Double.parseDouble(request.getParameter("latitudeDestinationCoordinateInput"));
        double destinationLongitude = Double.parseDouble(request.getParameter("longitudeDestinationCoordinateInput"));
        Destination destination = new Destination();
        destination.setName(destinationName);
        destination.setLatitude(destinationLatitude);
        destination.setLongitude(destinationLongitude);

//        //Save GPX File
//        response.setContentType("application/json");
//        String gpxContent = request.getParameter("gpxContent");
//
//        // Code for saving GPX file to database ...
//
//        //JSON message
//        response.getWriter().write("{\"success\": true, \"message\": \"Data saved successfully.\"}");

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
        String[] poiTypes = request.getParameterValues("poiTypeInput");

        Hike hike = new Hike();

        String hikeID = request.getParameter("hikeID");

        if (hikeID != null) {
            hike.setHikeID(Integer.parseInt(hikeID));
        }

        List<PointOfInterest> pointsOfInterest = new ArrayList<>();

        if(poiNames != null) {
            for (int i = 0; i < poiNames.length; i++) {
                PointOfInterest pointOfInterest = new PointOfInterest();
                pointOfInterest.setName(poiNames[i]);
                pointOfInterest.setLatitude(Double.parseDouble(poiLatitudes[i]));
                pointOfInterest.setLongitude(Double.parseDouble(poiLongitudes[i]));
                pointOfInterest.setDescription(poiDescriptions[i]);
                pointOfInterest.setType(poiTypes[i]);
                pointOfInterest.setHikePOI(hike);
                pointsOfInterest.add(pointOfInterest);
            }
        }

        hike.setPointsOfInterest(pointsOfInterest);

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

        HttpSession session = request.getSession();
        String hikerUsername = (String) session.getAttribute("hikerUsername");

        // Check if the user is logged in
        if (hikerUsername != null) {
            hike.setAuthor(hikerUsername);
        } else {
            System.out.println("User not logged in");
        }
        hike.setDate(currentDate);
        hike.setVisible(true);
        hike.setRegion("Bregenzerwald");

        FacadeJPA facadeJPA = FacadeJPA.getInstance();
        try {
            Thread.sleep(4 * 1000);
        } catch (InterruptedException ie) {
            Thread.currentThread().interrupt();
        }
        Picture picture = facadeJPA.getNewPicture();
        picture.setInUse(false);
        hike.setPreviewPicture(picture.getPictureID());
        facadeJPA.save(picture);
        facadeJPA.save(hike);
    }
}
