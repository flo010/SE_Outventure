package servlets;

import hibernate.facade.FacadeJPA;
import hibernate.model.Hike;
import hibernate.model.PointOfInterest;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;

import java.awt.*;
import java.io.IOException;

@WebServlet(name = "deletePOIServlet", value = "/delete_poi")
public class DeletePOIServlet extends HttpServlet {
    @Transactional
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        String poiIDsString = request.getParameter("poiIDString");
        String[] poiIDsArray = poiIDsString.split(",");
        int hikeID = Integer.parseInt(request.getParameter("hikeID"));

        FacadeJPA facadeJPA = FacadeJPA.getInstance();
        for (String poiIDString: poiIDsArray) {
            int poiID = Integer.parseInt(poiIDString);
            facadeJPA.removePOIFromHike(poiID, hikeID);
        }
    }
}