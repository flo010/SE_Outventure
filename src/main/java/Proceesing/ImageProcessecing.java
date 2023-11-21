package Proceesing;

import jakarta.servlet.http.Part;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class ImageProcessecing {
    // A utility method to convert Image to byte array
    public static byte[] extractBytes(Part image) throws IOException {
        InputStream imageStream = image.getInputStream();
        ByteArrayOutputStream imageOutput = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        int bytesRead;

        while ((bytesRead = imageStream.read(buffer)) != -1) {
            imageOutput.write(buffer, 0, bytesRead);
        }

        return imageOutput.toByteArray();
    }


}
