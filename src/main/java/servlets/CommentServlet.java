package servlets;

import hibernate.facade.FacadeJPA;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
@WebServlet(name = "CommentServlet", value = "/comment")
public class CommentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        response.setContentType("text/html");

        int hikeID = Integer.parseInt(request.getParameter("hikeID"));
        int hikerID = Integer.parseInt(request.getParameter("hikerID"));
        String commentText = request.getParameter("commentInput");

        FacadeJPA facadeJPA = FacadeJPA.getInstance();
        facadeJPA.addComment(hikeID, hikerID, commentText);

        response.sendRedirect("hike_detail?id=" + hikeID);

    }
}
