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
        String timestamp = request.getParameter("completionDate");
        String page = request.getParameter("page").toString();

        updateCompleted(hikerID, hikeID, timestamp);


        if (page.equals("detail")) {
            response.sendRedirect("hike_detail?id=" + hikeID);
        }
        else {
            response.sendRedirect("/completed_hike/completed_hike.jsp");
        }
    }

    private void updateCompleted(int hikerID, int hikeID, String timestamp) {
        FacadeJPA facadeJPA = FacadeJPA.getInstance();

            facadeJPA.addCompletedHike(hikerID, hikeID, timestamp);
            System.out.println("addFavorite called");

    }

}