package servlets;


import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;


import java.io.*;

@WebServlet(name = "Image", value = "/api/image")
@MultipartConfig
public class ImageServlet extends HttpServlet {
    /*public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String fileName = request.getParameter("imageSerach");
        System.out.println(System.getProperty("user.dir"));
        File dir = new File(".");
        File[] filesList = dir.listFiles();
        for (File file : filesList) {
            if (file.isFile()) {
                System.out.println(file.getName());
            }
        }
        response.setContentType("image/png");
        ServletOutputStream out;
        String imagePath = "../../../../images/mountain.png";
        try (InputStream in = Files.newInputStream(Paths.get(imagePath))) {
            // Copy the image data to the response output stream
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                response.getOutputStream().write(buffer, 0, bytesRead);
            }
        } catch (IOException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    */

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }
}