package servlets;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import hibernate.facade.FacadeJPA;
import hibernate.model.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

import java.io.BufferedReader;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "saveDataServlet", value = "/save_data")
public class SaveDataServlet extends HttpServlet {
    @Transactional
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        boolean isEdit = Boolean.parseBoolean(request.getParameter("edit"));

        if (isEdit) {
            int pictureID = Integer.parseInt(request.getParameter("pictureID"));
            saveToDatabase(request,response);

            int hikeID = Integer.parseInt(request.getParameter("hikeID"));
            response.sendRedirect("hike_detail?id=" + hikeID + "&hikeEdited=true");
        }
        else {
            saveToDatabase(request, response);
            response.sendRedirect("/search_results?hikeCreated=true");
        }
    }

    private void saveToDatabase(HttpServletRequest request, HttpServletResponse response) throws IOException {
        System.out.println("latDest " + Double.parseDouble(request.getParameter("latitudeDestinationCoordinateInput")));

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


        //Save GPX File
        response.setContentType("application/json");
        StringBuilder requestBody = new StringBuilder();

        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                requestBody.append(line);
            }
        } catch (IOException e) {
            e.printStackTrace(); // Log the exception
        }

        System.out.println("Request Body: " + requestBody.toString()); // Log the request body

        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode jsonNode = null;

        try {
            jsonNode = objectMapper.readTree(requestBody.toString());
        } catch (IOException e) {
            e.printStackTrace(); // Log the exception
        }

        if (jsonNode != null) {

            System.out.println("Received JSON Node: " + jsonNode.toString());

            String hike = request.getParameter("hikeID");
            String gpxContent = jsonNode.has("gpxContent") ? jsonNode.get("gpxContent").asText() : null;
            System.out.println("Received gpxContent: " + gpxContent);

            FacadeJPA facadeJPA = FacadeJPA.getInstance();
            facadeJPA.addGpxFile(hike, gpxContent);
        } else {
            System.err.println("Failed to parse JSON data.");
        }


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
        String pictureID = request.getParameter("hiddenImageId");
        System.out.println("pictureID");
        System.out.println(pictureID);
        Hike hike = new Hike();
        hike.setPreviewPicture(pictureID);
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

        Region region = new Region();
        region.setRegionID(1);
        region.setRegion("Österreich - Vorarlberg");
        hike.setRegion(region);

        FacadeJPA facadeJPA = FacadeJPA.getInstance();

        facadeJPA.save(hike);
    }
}
