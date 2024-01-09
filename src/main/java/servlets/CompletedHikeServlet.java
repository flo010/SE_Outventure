package servlets;

import hibernate.facade.FacadeJPA;
import hibernate.model.Hike;
import hibernate.model.Hiker;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "completedHikeServlet", value = "/completed_hike")
public class CompletedHikeServlet extends HttpServlet {
    public static FacadeJPA facadeJPA = FacadeJPA.getInstance();
    @Transactional
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        HttpSession session = request.getSession();
        int hikerID = (int) session.getAttribute("hikerID");
        System.out.println("SERVLET IS CALLED");
        System.out.println("hikerID: " + hikerID);

        Hiker hiker = facadeJPA.getHikerByID(hikerID);
        List<Hike> completedHikes =  hiker.getCompletedHikes();
        List<Date> timestamps = facadeJPA.getCompletedHikesTimestamps(hikerID);

        request.setAttribute("completedHikes", completedHikes);
        request.setAttribute("timestamps", timestamps);
        request.setAttribute("hikerID", hikerID);
        response.sendRedirect("/completed_hikes/completed_hikes.jsp");
    }

    @Transactional
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        int hikeID = Integer.parseInt(request.getParameter("hikeID"));
        int hikerID = Integer.parseInt(request.getParameter("hikerID"));
        String timestamp = request.getParameter("completionDate");
        String page = request.getParameter("page");

        Hiker hiker = facadeJPA.getHikerByID(hikerID);
        List<Hike> completedHikes =  hiker.getCompletedHikes();
        List<Date> timestamps = facadeJPA.getCompletedHikesTimestamps(hikerID);

        if (page.equals("detail")) {
            addCompleted(hikerID, hikeID, timestamp);
            response.sendRedirect("hike_detail?id=" + hikeID);
        }
        else if (page.equals("profile")) {
            removeCompleted(hikeID, hikerID, timestamp);
            request.setAttribute("completedHikes", completedHikes);
            request.setAttribute("timestamps", timestamps);
            response.sendRedirect("/completed_hikes/completed_hikes.jsp");
        }
    }

    private void addCompleted(int hikerID, int hikeID, String timestamp) {
        facadeJPA.addCompletedHike(hikerID, hikeID, timestamp);
    }

    private void removeCompleted(int hikeID, int hikerID, String timestamp) {
        facadeJPA.removeCompletedHike(hikeID, hikerID, timestamp);
    }
}