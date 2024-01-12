package servlets;

import hibernate.facade.FacadeJPA;
import hibernate.model.Hike;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

import java.io.IOException;

@WebServlet(name = "deleteHikeServlet", value = "/delete_hike")
public class DeleteHikeServlet extends HttpServlet {
    public static FacadeJPA facadeJPA = FacadeJPA.getInstance();
    @Transactional
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        int hikeID = Integer.parseInt(request.getParameter("hikeID"));

        setVisibleFalse(hikeID);

        HttpSession session = request.getSession();
        session.setAttribute("hikeDeleted", true);
        response.sendRedirect("/profile_hike_list");
    }

    private void setVisibleFalse(int hikeID) {
        Hike hike = facadeJPA.getHikeByIDLazy(hikeID);

        hike.setVisible(false);

        facadeJPA.save(hike);
    }
}