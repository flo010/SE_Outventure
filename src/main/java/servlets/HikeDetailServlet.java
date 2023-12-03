package servlets;

import hibernate.facade.FacadeJPA;
import hibernate.model.Hike;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;

import java.io.IOException;

@WebServlet(name = "hikeDetailServlet", value = "/hike_detail")
public class HikeDetailServlet extends HttpServlet {
    @Transactional
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        String hikeEdited = request.getParameter("hikeEdited");
        request.setAttribute("hikeEdited", hikeEdited);

        int hikeID = Integer.parseInt(request.getParameter("id"));

        FacadeJPA facadeJPA = FacadeJPA.getInstance();
        Hike hike = facadeJPA.getHikeByIDEager(hikeID);

        request.setAttribute("hike", hike);

        try {
            request.getRequestDispatcher("/hike_detail/hike_detail.jsp").forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }
}