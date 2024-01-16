package servlets;

public class APIKeys {
    public static final String weatherApiKey = "334ec4fd65c0ffc4a300322db9a07b40";
    public static final String routingApiKey = "5b3ce3597851110001cf62483d1f73a95e10453194e38bd4eb0fd59c";

    public static String getWeatherApiKey() {
        return weatherApiKey;
    }
    public static String getRoutingApiKey() {
        return routingApiKey;
    }
}
