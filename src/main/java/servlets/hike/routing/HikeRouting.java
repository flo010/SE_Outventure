package servlets.hike.routing;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.core.Response;
import java.util.List;

public class HikeRouting {

    public static String route(List<Double[]> coords) {
        StringBuilder coordsString = new StringBuilder();
        coordsString.append("[[");
        for (int i = 0; i < coords.size(); i++) {
            if(i != 0){
                coordsString.append("],[");
            }
            coordsString.append(coords.get(i)[0]);
            coordsString.append(",");
            coordsString.append(coords.get(i)[1]);
        }
        coordsString.append("]]");
        Client client = ClientBuilder.newClient();

        // Constructing the JSON payload as a String
        String jsonPayload = "{\"coordinates\":"+coordsString+",\"elevation\":\"true\",\"extra_info\":[\"steepness\",\"suitability\",\"surface\",\"green\",\"noise\"]}";

        Entity<String> payload = Entity.json(jsonPayload);

        Response response = client.target("https://api.openrouteservice.org/v2/directions/foot-hiking/gpx")
                .request()
                .header("Authorization", "Bearer " + APIKeys.getRoutingApiKey()) // Assuming it's a bearer token
                .header("Accept", "application/json, application/geo+json, application/gpx+xml, img/png")
                .header("Content-Type", "application/json")
                .post(payload);
        String responseString = response.readEntity(String.class);
        // Close the client to free resources
        client.close();
        return  responseString;
    }
}
