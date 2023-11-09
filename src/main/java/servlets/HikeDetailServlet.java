package servlets;

import java.io.*;
import java.util.List;

import hibernate.facade.FacadeJPA;
import hibernate.model.Hike;
import hibernate.model.PointOfInterest;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "hikeDetailServlet", value = "/hike_detail")
public class HikeDetailServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        int hikeID = Integer.parseInt(request.getParameter("id"));
        FacadeJPA facadeJPA = FacadeJPA.getInstance();
        Hike hike = facadeJPA.getHikeByID(hikeID);

        List<PointOfInterest> pointsOfInterest = hike.getPointOfInterests();

        request.setAttribute("hike", hike);
        request.setAttribute("pointsOfInterest", pointsOfInterest);

        try {
            request.getRequestDispatcher("/hike_detail.jsp").forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }
}