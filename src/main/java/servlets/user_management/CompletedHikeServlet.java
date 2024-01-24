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
import java.util.List;

@WebServlet(name = "completedHikeServlet", value = "/completed_hike")
public class CompletedHikeServlet extends HttpServlet {
    public static FacadeJPA facadeJPA = FacadeJPA.getInstance();
    @Transactional
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");

        HttpSession session = request.getSession();
        int hikerID = (int) session.getAttribute("hikerID");

        Hiker hiker = facadeJPA.getHikerByID(hikerID);
        List<Hike> completedHikes =  hiker.getCompletedHikes();
        List<Date> timestamps = facadeJPA.getCompletedHikesTimestamps(hikerID);

        request.setAttribute("completedHikes", completedHikes);
        request.setAttribute("timestamps", timestamps);
        request.setAttribute("hikerID", hikerID);
        request.getRequestDispatcher("/user_management/completed_hikes_list/completed_hikes_list.jsp").forward(request, response);
    }

    @Transactional
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");

        int hikeID = Integer.parseInt(request.getParameter("hikeID"));
        int hikerID = Integer.parseInt(request.getParameter("hikerID"));
        String timestamp = request.getParameter("completionDate");
        String page = request.getParameter("page");

        if (page.equals("detail")) {
            addCompleted(hikerID, hikeID, timestamp);
            response.sendRedirect("hike_detail?id=" + hikeID);
        }
        else if (page.equals("profile")) {
            removeCompleted(hikeID, hikerID, timestamp);

            Hiker hiker = facadeJPA.getHikerByID(hikerID);
            List<Hike> completedHikes =  hiker.getCompletedHikes();
            List<Date> timestamps = facadeJPA.getCompletedHikesTimestamps(hikerID);

            request.setAttribute("completedHikes", completedHikes);
            request.setAttribute("timestamps", timestamps);
            request.setAttribute("hikerID", hikerID);
            request.getRequestDispatcher("/user_management/completed_hikes_list/completed_hikes_list.jsp").forward(request, response);
        }
    }

    private void addCompleted(int hikerID, int hikeID, String timestamp) {
        facadeJPA.addCompletedHike(hikerID, hikeID, timestamp);
    }

    private void removeCompleted(int hikeID, int hikerID, String timestamp) {
        facadeJPA.removeCompletedHike(hikeID, hikerID, timestamp);
    }
}