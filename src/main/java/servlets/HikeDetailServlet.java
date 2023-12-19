package servlets;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import hibernate.facade.FacadeJPA;
import hibernate.model.Hike;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.core.Response;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

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
        request.setAttribute(
                "weatherList",
                getWeatherList(hike.getStart().getLatitude(), hike.getStart().getLongitude())
        );

        try {
            request.getRequestDispatcher("/hike_detail/hike_detail.jsp").forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }

    private ArrayList<ArrayList<String>> getWeatherList(double latitude, double longitude) {
        Client client = ClientBuilder.newClient();
        String url = "https://api.openweathermap.org/data/2.5/forecast/daily?lat=" + latitude + "&lon=" + longitude + "&cnt=4&units=metric&appid=334ec4fd65c0ffc4a300322db9a07b40";

        Response weatherApiResponse = client.target(url)
                .request()
                .get();

        JsonElement jsonElement = JsonParser.parseString(weatherApiResponse.readEntity(String.class));

        client.close();

        JsonObject jsonObject = jsonElement.getAsJsonObject();
        JsonArray weatherData = jsonObject.get("list").getAsJsonArray();

        ArrayList<ArrayList<String>> weatherList = new ArrayList<>();

        for (int i = 0; i < 4; i++) {
            JsonObject listEntry = weatherData.get(i).getAsJsonObject();

            String temp = Integer.toString(Math.round(listEntry.getAsJsonObject("temp").get("day").getAsFloat()));

            String iconId = listEntry.getAsJsonArray("weather").get(0).getAsJsonObject().get("icon").getAsString();
            String iconPath = "https://openweathermap.org/img/wn/" + iconId + "@2x.png";

            Date date = new Date(listEntry.get("dt").getAsLong() * 1000L);
            SimpleDateFormat dateFormat = new SimpleDateFormat("E, MMM dd yyyy", Locale.ENGLISH);
            String formattedDate = dateFormat.format(date);

            ArrayList<String> weatherAttributes = new ArrayList<>();
            weatherAttributes.add(temp);
            weatherAttributes.add(iconPath);
            weatherAttributes.add(formattedDate);
            weatherList.add(weatherAttributes);
        }

        return weatherList;
    }
}