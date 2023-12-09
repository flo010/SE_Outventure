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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        int hikeID = Integer.parseInt(request.getParameter("hikeID"));
        int hikerID = Integer.parseInt(request.getParameter("hikerID"));
        String page = request.getParameter("page").toString();

        System.out.println(hikeID);
        System.out.println(hikerID);

        updateFavorites(hikerID, hikeID);

        if (page.equals("detail")) {
            response.sendRedirect("hike_detail?id=" + hikeID);
        }
        else {
            response.sendRedirect("/favorite_hike/favorite_hike.jsp");
        }
    }

    private void updateFavorites(int hikerID, int hikeID) {
        FacadeJPA facadeJPA = FacadeJPA.getInstance();
        boolean isFavorite = facadeJPA.isFavoriteHikeExists(hikerID, hikeID);

        if (!isFavorite) {
            facadeJPA.addFavoriteHike(hikerID, hikeID);
            System.out.println("addFavorite called");
        }
        else {
            facadeJPA.removeFavoriteHike(hikerID, hikeID);
            System.out.println("removeFavorite called");
        }
    }
}