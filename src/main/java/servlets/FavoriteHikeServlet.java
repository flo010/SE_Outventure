package servlets;

import hibernate.facade.FacadeJPA;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;

import java.io.IOException;

@WebServlet(name = "favoriteHikeServlet", value = "/favorite_hike")
public class FavoriteHikeServlet extends HttpServlet {
    @Transactional
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        int hikeID = Integer.parseInt(request.getParameter("hikeID"));
        int hikerID = Integer.parseInt(request.getParameter("hikerID"));

        updateFavorites(hikerID, hikeID);

        // Redirect back to the hike details page or any other appropriate page
        response.sendRedirect("hike_detail?id=" + hikeID);
    }

    private void updateFavorites(int hikerID, int hikeID) {
        FacadeJPA facadeJPA = FacadeJPA.getInstance();
        boolean isFavorite = facadeJPA.isFavoriteHikeExists(hikerID, hikeID);

        if (!isFavorite) {
            facadeJPA.addFavoriteHike(hikerID, hikeID);
        }
        else {
            facadeJPA.removeFavoriteHike(hikerID, hikeID);
        }
    }
}