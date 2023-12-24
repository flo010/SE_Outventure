package servlets;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


public class ExportGpxServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Assuming gpxData is the variable holding your GPX data as a string
        String gpxData = getGpxData(); // Replace this with your actual method to get GPX data

        // Set the content type and headers for a GPX file
        response.setContentType("application/gpx+xml");
        response.setHeader("Content-Disposition", "attachment; filename=exported.gpx");

        // Write the GPX data directly to the response output stream
        try (PrintWriter out = response.getWriter()) {
            out.print(gpxData);
        } catch (IOException e) {
            e.printStackTrace();
            // Handle the exception as needed
        }
    }

    // Replace this method with your actual method to get GPX data
    private String getGpxData() {
        // Your logic to obtain the GPX data as a string
        return "Your GPX data as a string";
    }
}
