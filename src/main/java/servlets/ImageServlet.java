package servlets;


import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.mockito.Mockito;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;


import java.io.*;
import java.sql.Blob;
import java.sql.SQLException;

import static Proceesing.ImageProcessecing.extractBytes;

@WebServlet(name = "Image", value = "/api/image")
@MultipartConfig
public class ImageServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Assuming you have the byte[] representation of your image
        byte[] imageData = getImageAsByteArray(); // Replace this with your logic to retrieve the image bytes

        // Set the content type of the response to indicate an image
        response.setContentType("image/jpeg"); // Change the content type based on your image type

        // Write the image data to the response output stream
        OutputStream outputStream = response.getOutputStream();
        outputStream.write(imageData);
        outputStream.close();
    }

        // Method to retrieve the image Blob (You need to implement this method)
        private byte[] getImageAsByteArray() {
            String imagePath = "C:\\Users\\flo01\\Projects\\SE_Outventure\\src\\test\\java\\Proceesing\\bad-mitterndorf-mit-grimming-25240459.jpg";
            File file = new File(imagePath);
            FileInputStream fileInputStream = null;
            try {
                fileInputStream = new FileInputStream(file);
            } catch (FileNotFoundException e) {
                throw new RuntimeException(e);
            }

            // Create a MockPart and set necessary attributes
            Part mockPart = Mockito.mock(Part.class);
            try {
                Mockito.when(mockPart.getInputStream()).thenReturn(fileInputStream);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            Mockito.when(mockPart.getSubmittedFileName()).thenReturn(file.getName());
            Mockito.when(mockPart.getSize()).thenReturn(file.length());
            Mockito.when(mockPart.getHeader(Mockito.anyString())).thenReturn("image/jpeg"); // Change content type if needed
            Mockito.when(mockPart.getContentType()).thenReturn("image/jpeg"); // Change content type if needed
            Mockito.when(mockPart.getName()).thenReturn("file"); // Name of the input type for file upload

            try {
                byte[] test = extractBytes(mockPart);
                return test;
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
}