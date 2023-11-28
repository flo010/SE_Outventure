package servlets;


import hibernate.facade.FacadeJPA;
import hibernate.model.Picture;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

@WebServlet(name = "Image", value = "/api/image/*")
@MultipartConfig
public class ImageServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Assuming you have the byte[] representation of your image
        int id = -1;
        byte[] imageData = null;
        String[] pathInfo =request.getPathInfo().split("/");
        for (String s : pathInfo) {
            System.out.println(s);
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
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            Part filePart = request.getPart("image");

            InputStream is = filePart.getInputStream();
            byte[] compressedImageData = getBytesFromInputStream(is);
            Picture picture = saveToDatabase(compressedImageData);
            System.out.println("Test picture");
            System.out.println(picture.getPictureID());


            // Create a JSON object with the picture ID
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("pictureID", picture.getPictureID());



            response.setContentType("application/json");
            response.getWriter().write(jsonResponse.toString());
        } catch (Exception e) {
            response.setContentType("application/json");
            response.getWriter().write("{ \"error\": \"" + e.getMessage() + "\" }");
        }
    }

    private byte[] getBytesFromInputStream(InputStream is) throws IOException {
        ByteArrayOutputStream buffer = new ByteArrayOutputStream();

        int nRead;
        byte[] data = new byte[1024];

        while ((nRead = is.read(data, 0, data.length)) != -1) {
            buffer.write(data, 0, nRead);
        }

        buffer.flush();

        return buffer.toByteArray();
    }

    private Picture saveToDatabase(byte[] compressedImageData) {
        FacadeJPA facadeJPA = FacadeJPA.getInstance();

        Picture picture = new Picture();
        picture.setPicture(compressedImageData);
        picture.setInUse(true);
        Picture savedPicture = (Picture) (facadeJPA.save(picture));
        System.out.println("Saving compressed image to the database. Image size: " + compressedImageData.length + " bytes");
        System.out.println(savedPicture.getPictureID());
        return savedPicture;
    }
}