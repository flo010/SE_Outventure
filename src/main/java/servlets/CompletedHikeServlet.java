package servlets;

import hibernate.facade.FacadeJPA;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;

import java.io.IOException;

@WebServlet(name = "completedHikeServlet", value = "/completed_hike")
public class CompletedHikeServlet extends HttpServlet {
    public static FacadeJPA facadeJPA = FacadeJPA.getInstance();
    @Transactional
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

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
            response.sendRedirect("/completed_hikes/completed_hikes.jsp");
        }
    }

    private void addCompleted(int hikerID, int hikeID, String timestamp) {
        facadeJPA.addCompletedHike(hikerID, hikeID, timestamp);
    }

    private void removeCompleted(int hikeID, int hikerID, String timestamp) {
        FacadeJPA facadeJPA = FacadeJPA.getInstance();
        facadeJPA.removeCompletedHike(hikeID, hikerID, timestamp);
    }
}