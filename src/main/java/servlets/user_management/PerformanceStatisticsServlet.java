package servlets.user_management;

import hibernate.facade.FacadeJPA;
import hibernate.model.Hike;
import hibernate.model.Hiker;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "performanceStatisticsServlet", value = "/performance_statistics")
public class PerformanceStatisticsServlet extends HttpServlet {
    public static FacadeJPA facadeJPA = FacadeJPA.getInstance();

    @Transactional
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        int hikerID = (int) session.getAttribute("hikerID");
        Hiker hiker = facadeJPA.getHikerByID(hikerID);
        List<Hike> completedHikes = hiker.getCompletedHikes();
        List<Date> timestamps = facadeJPA.getCompletedHikesTimestamps(hikerID);
        Date fromDate = Date.valueOf(request.getParameter("fromDate"));
        Date toDate = Date.valueOf(request.getParameter("toDate"));

        List<Hike> filteredHikes = new ArrayList<>();

        for (int i = 0; i < timestamps.size(); i += 1) {
            if ((timestamps.get(i).compareTo(fromDate) >= 0) && (timestamps.get(i).compareTo(toDate) <= 0)) {
                filteredHikes.add(completedHikes.get(i));
            }
        }

        double[] calculatedValues = calculateValues(filteredHikes);
        double totalDistance = calculatedValues[0];
        double totalDuration = calculatedValues[1];
        int totalAltitude = (int) calculatedValues[2];

        session.setAttribute("filteredHikes", filteredHikes);
        session.setAttribute("totalDistance", totalDistance);
        session.setAttribute("totalDuration", totalDuration);
        session.setAttribute("totalAltitude", totalAltitude);

        session.setAttribute("fromDate", fromDate);
        session.setAttribute("toDate", toDate);
        if (!filteredHikes.isEmpty()) {
            session.setAttribute("empty", false);
        }
        else {
            session.setAttribute("empty", true);
        }
        response.sendRedirect("/user_management/performance_statistics/performance_statistics.jsp");
    }

    public double[] calculateValues(List<Hike> filteredHikes) {
        double totalDistance = 0.0;
        double totalDuration = 0.0;
        int totalAltitude = 0;

        for (Hike hike : filteredHikes) {
            totalDistance += hike.getDistance();
            totalDuration += hike.getDuration();
            totalAltitude += hike.getAltitude();
        }

        double[] calculatdValues = {totalDistance, totalDuration, totalAltitude};

        return calculatdValues;
    }
}