package servlets;


import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;
import org.json.JSONArray;
import processing.HikeRouting;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "RouteServlet", value = "/route")
public class RouteServlet extends HttpServlet {
    @Transactional
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/xml;charset=UTF-8");
        BufferedReader reader = request.getReader();
        StringBuilder jsonStringBuilder = new StringBuilder();
        String line;
        while ((line = reader.readLine())!= null){
            jsonStringBuilder.append(line);
        }
        String jsonString = jsonStringBuilder.toString();
        System.out.println(jsonString);
        JSONArray routeArray = new JSONArray(jsonString);

        ArrayList<Double[]> waypoints= new ArrayList<>();
        for (int i = 0; i < routeArray.length(); i++) {
            waypoints.add(new Double[]{routeArray.getJSONArray(i).getDouble(0), routeArray.getJSONArray(i).getDouble(1)});
            System.out.println(routeArray.getJSONArray(i).getDouble(0) + "," + routeArray.getJSONArray(i).getDouble(1));
        }
        String route = HikeRouting.route(waypoints);
        response.getWriter().write(route);
    }
}