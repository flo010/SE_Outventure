package Proceesing;

import hibernate.broker.PictureBroker;
import hibernate.model.Picture;
import jakarta.servlet.http.Part;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.io.*;
import java.util.Arrays;

import static Proceesing.ImageProcessecing.extractBytes;


class ImageProcessecingTest {

    @Test
    void extractBytesTest() throws IOException {
        String[] imagePaths =
                {
                        "src/test/java/Proceesing/2.jpg",
                        "src/test/java/Proceesing/3.jpg",
                        "src/test/java/Proceesing/4.jpg",
                        "src/test/java/Proceesing/5.jpg",
                        "src/test/java/Proceesing/6.jpg",
                        "src/test/java/Proceesing/7.jpg",
                        "src/test/java/Proceesing/ezgif-2-d1850fad73.jpg",
                        "src/test/java/Proceesing/niederkaiserkamm-14871-0.jpg",
                };

        for (String imagePath : imagePaths) {
            File file = new File(imagePath);
            FileInputStream fileInputStream = new FileInputStream(file);

            // Create a MockPart and set necessary attributes
            Part mockPart = Mockito.mock(Part.class);
            Mockito.when(mockPart.getInputStream()).thenReturn(fileInputStream);
            Mockito.when(mockPart.getSubmittedFileName()).thenReturn(file.getName());
            Mockito.when(mockPart.getSize()).thenReturn(file.length());
            Mockito.when(mockPart.getHeader(Mockito.anyString())).thenReturn("image/jpeg"); // Change content type if needed
            Mockito.when(mockPart.getContentType()).thenReturn("image/jpeg"); // Change content type if needed
            Mockito.when(mockPart.getName()).thenReturn("file"); // Name of the input type for file upload

            byte[] test = extractBytes(mockPart);
            Picture picture = new Picture();
            picture.setBase64(Arrays.toString(test));
            PictureBroker p = new PictureBroker();
            p.save(picture);

        }
    }

}