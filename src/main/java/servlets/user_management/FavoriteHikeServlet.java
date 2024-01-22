package servlets.user_management;

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");

        int hikeID = Integer.parseInt(request.getParameter("hikeID"));
        int hikerID = Integer.parseInt(request.getParameter("hikerID"));
        String page = request.getParameter("page");

        switch (page) {
            case "detail":
                updateFavorites(hikerID, hikeID);
                response.sendRedirect("hike_detail?id=" + hikeID);
                break;
            case "profile": {
                updateFavorites(hikerID, hikeID);
                Hiker hiker = facadeJPA.getHikerByID(hikerID);
                List<Hike> favoriteHikes = hiker.getFavoriteHikes();
                request.setAttribute("favoriteHikes", favoriteHikes);
                request.getRequestDispatcher("/user_management/favorite_hikes_list/favorite_hikes_list.jsp").forward(request, response);
                break;
            }
            case "left-box": {
                Hiker hiker = facadeJPA.getHikerByID(hikerID);
                List<Hike> favoriteHikes = hiker.getFavoriteHikes();
                request.setAttribute("favoriteHikes", favoriteHikes);
                request.getRequestDispatcher("/user_management/favorite_hikes_list/favorite_hikes_list.jsp").forward(request, response);
                break;
            }
        }
    }

    private void updateFavorites(int hikerID, int hikeID) {
        boolean isFavorite = facadeJPA.isFavoriteHikeExists(hikerID, hikeID);

        if (!isFavorite) {
            facadeJPA.addFavoriteHike(hikerID, hikeID);
        }
        else {
            facadeJPA.removeFavoriteHike(hikerID, hikeID);
        }
    }
}