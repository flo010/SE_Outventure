package servlets;

import com.google.gson.Gson;
import hibernate.facade.FacadeJPA;
import hibernate.model.Hike;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.util.List;
@WebServlet(name = "Search", value = "/api/search")
public class SearchServlet extends HttpServlet {
        public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            String title = request.getParameter("search");
            FacadeJPA facadeJPA = FacadeJPA.getInstance();
            Hike hikeList = facadeJPA.getHikeByIDEager(1);

            JSONObject hike = new JSONObject();
            hike.put("title",hikeList.getTitle());
            hike.put("distance",hikeList.getDistance());
            hike.put("duration",hikeList.getDuration());
            hike.put("altitude",hikeList.getAltitude());

            PrintWriter out = response.getWriter();
            out.println(hike.toString());

        }
}
