package servlets;

import java.io.*;

import hibernate.facade.FacadeJPA;
import hibernate.model.Hike;
import hibernate.model.Picture;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.transaction.Transactional;

@WebServlet(name = "hikeDetailServlet", value = "/hike_detail")
public class HikeDetailServlet extends HttpServlet {
    @Transactional
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        int hikeID = Integer.parseInt(request.getParameter("id"));
        int pictureId = Integer.parseInt(request.getAttribute("pictureId").toString());

        FacadeJPA facadeJPA = FacadeJPA.getInstance();
        Hike hike = facadeJPA.getHikeByIDEager(hikeID);
        Picture picture = facadeJPA.getPictureByID(pictureId);

        request.setAttribute("hike", hike);
        try {
            request.getRequestDispatcher("/hike_detail.jsp").forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }
}