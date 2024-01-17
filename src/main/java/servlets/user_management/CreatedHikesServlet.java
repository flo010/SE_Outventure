package servlets.user_management;

import hibernate.facade.FacadeJPA;
import hibernate.model.Hike;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CreatedHikesServlet", value = "/profile_hike_list")
public class CreatedHikesServlet extends HttpServlet {
    public static FacadeJPA facadeJPA = FacadeJPA.getInstance();
    @Transactional
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        HttpSession session = request.getSession();
        String hikerUsername =  (String) session.getAttribute("hikerUsername");
        List<Hike> createdHikes = facadeJPA.getHikesByAuthorLazy(hikerUsername);

        request.setAttribute("createdHikes", createdHikes);

        try {
            request.getRequestDispatcher("/user_management/created_hikes_list/created_hikes_list.jsp").forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }
}