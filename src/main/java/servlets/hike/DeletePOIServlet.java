package servlets.hike;

import hibernate.facade.FacadeJPA;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;

@WebServlet(name = "deletePOIServlet", value = "/delete_poi")
public class DeletePOIServlet extends HttpServlet {
    public static FacadeJPA facadeJPA = FacadeJPA.getInstance();
    @Transactional
    public void doGet(HttpServletRequest request, HttpServletResponse response) {
        response.setContentType("text/html");

        String poiIDsString = request.getParameter("poiIDString");
        String[] poiIDsArray = poiIDsString.split(",");
        int hikeID = Integer.parseInt(request.getParameter("hikeID"));

        for (String poiIDString: poiIDsArray) {
            int poiID = Integer.parseInt(poiIDString);
            facadeJPA.removePOIFromHike(poiID, hikeID);
        }
    }
}