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

@WebServlet(name = "hikeDetailServlet", value = "/save_data")
public class SaveDataServlet extends HttpServlet {
    private static int _idCounter = 20;

    private int getNextID() {
        _idCounter += 1;

        return _idCounter;
    }

    @Transactional
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        int hikeId = getNextID();
        String title = request.getParameter("titleInput");
        String description = request.getParameter("descriptionInput");
        double duration = 1.1;
        double distance = 1.1;
        int altitude = 1;

        Start start = new Start();
        start.setStartID(99);
        start.setName("Start");
        start.setLatitude(40.12);
        start.setLongitude(10.2);

        Destination destination = new Destination();
        destination.setDestinationID(90);
        destination.setName("Destination");
        destination.setLatitude(42.12);
        destination.setLongitude(10.12);

        int strength = 1;
        int stamina = 1;
        int experience = 1;
        int landscape = 1;
        boolean january = true;
        boolean february = false;
        boolean march = false;
        boolean april = false;
        boolean may = false;
        boolean june = false;
        boolean july = false;
        boolean august = false;
        boolean september = false;
        boolean october = false;
        boolean november = false;
        boolean december = false;
        String routeDescription = "Route Description";

        Hike hike = new Hike();
        hike.setHikeID(hikeId);
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

        FacadeJPA facadeJPA = FacadeJPA.getInstance();
        facadeJPA.save(hike);

        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }

    @Transactional
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        System.out.println(request.getContextPath() + "/index.jsp");
    }
}
