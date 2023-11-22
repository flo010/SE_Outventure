package servlets;


import hibernate.facade.FacadeJPA;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.mockito.Mockito;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;


import java.io.*;
import java.sql.Blob;
import java.sql.SQLException;

import static Proceesing.ImageProcessecing.extractBytes;

@WebServlet(name = "Image", value = "/api/image/*")
@MultipartConfig
public class ImageServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Assuming you have the byte[] representation of your image
        int id = -1;
        byte[] imageData = null;
        String[] pathInfo =request.getPathInfo().split("/");
        for (int i = 0; i < pathInfo.length; i++) {
            System.out.println(pathInfo[i]);
        }
        FacadeJPA facadeJPA = FacadeJPA.getInstance();
        if(pathInfo.length == 2){
            id=Integer.parseInt(pathInfo[1]);
        }
        if(id!=-1){
            imageData= facadeJPA.getPictureByID(id).getPicture();
        }
        if(imageData != null) {
            // Set the content type of the response to indicate an image
            response.setContentType("image/jpeg"); // Change the content type based on your image type

            // Write the image data to the response output stream
            OutputStream outputStream = response.getOutputStream();
            outputStream.write(imageData);
            outputStream.close();
        }
    }
}