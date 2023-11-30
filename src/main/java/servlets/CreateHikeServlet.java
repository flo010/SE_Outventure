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

@WebServlet(name = "createHikeServlet", value = "/create/hike")
public class CreateHikeServlet extends HttpServlet {
    @Transactional
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        String hikeParameter = request.getParameter("hikeID");


        if(hikeParameter != null) {

            int hikeID = Integer.parseInt(hikeParameter);


            FacadeJPA facadeJPA = FacadeJPA.getInstance();
            Hike hike = facadeJPA.getHikeByIDEager(hikeID);

            request.setAttribute("hike", hike);
        }

        try {
            request.getRequestDispatcher("/create_hike.jsp").forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }
}