package servlets;

import hibernate.facade.FacadeJPA;
import hibernate.model.Hike;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;

import java.io.IOException;

@WebServlet(name = "deleteHikeServlet", value = "/delete_hike")
public class DeleteHikeServlet extends HttpServlet {
    @Transactional
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        int hikeID = Integer.parseInt(request.getParameter("hikeID"));

        // Update visibility in the database
        setVisibleFalse(hikeID);

        // Redirect back to the hike details page or any other appropriate page
        response.sendRedirect("search_results?hikeDeleted=true");
    }

    private void setVisibleFalse(int hikeID) {
        FacadeJPA facadeJPA = FacadeJPA.getInstance();
        Hike hike = facadeJPA.getHikeByIDLazy(hikeID);

        hike.setVisible(false);

        facadeJPA.save(hike);
    }
}