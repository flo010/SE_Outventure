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
    @Transactional
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        response.setContentType("text/html");

        int hikeID = Integer.parseInt(request.getParameter("hikeID"));
        int hikerID = Integer.parseInt(request.getParameter("hikerID"));
        String timestamp;
        String page = request.getParameter("page").toString();

        if (page.equals("detail")) {
            timestamp = request.getParameter("completionDate");
            addCompleted(hikerID, hikeID, timestamp);
            response.sendRedirect("hike_detail?id=" + hikeID);
        }
        else {
            removeCompleted(hikeID, hikerID);
            response.sendRedirect("/completed_hikes/completed_hikes.jsp");
        }
    }

    private void addCompleted(int hikerID, int hikeID, String timestamp) {
        FacadeJPA facadeJPA = FacadeJPA.getInstance();
        facadeJPA.addCompletedHike(hikerID, hikeID, timestamp);
    }

    private void removeCompleted(int hikeID, int hikerID) {
        FacadeJPA facadeJPA = FacadeJPA.getInstance();
        facadeJPA.removeCompletedHike(hikeID, hikerID);
    }
}