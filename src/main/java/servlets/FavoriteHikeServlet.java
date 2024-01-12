package servlets;

import hibernate.facade.FacadeJPA;
import hibernate.model.Hike;
import hibernate.model.Hiker;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "favoriteHikeServlet", value = "/favorite_hike")
public class FavoriteHikeServlet extends HttpServlet {
    public static FacadeJPA facadeJPA = FacadeJPA.getInstance();
    @Transactional
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        int hikeID = Integer.parseInt(request.getParameter("hikeID"));
        int hikerID = Integer.parseInt(request.getParameter("hikerID"));
        String page = request.getParameter("page").toString();

        if (page.equals("detail")) {
            updateFavorites(hikerID, hikeID);
            response.sendRedirect("hike_detail?id=" + hikeID);
        }
        else if (page.equals("profile")) {
            updateFavorites(hikerID, hikeID);
            response.sendRedirect("/favorite_hike/favorite_hike.jsp");
        }
        else {
            Hiker hiker = facadeJPA.getHikerByID(hikerID);
            List<Hike> favoriteHikes =  hiker.getFavoriteHikes();

            request.setAttribute("favoriteHikes", favoriteHikes);

            try {
                request.getRequestDispatcher("/favorite_hike/favorite_hike.jsp").forward(request, response);
            } catch (ServletException e) {
                throw new RuntimeException(e);
            }
        }
    }

    private void updateFavorites(int hikerID, int hikeID) {
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