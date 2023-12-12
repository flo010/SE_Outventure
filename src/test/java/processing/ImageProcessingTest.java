package processing;

import hibernate.broker.PictureBroker;
import hibernate.model.Picture;
import jakarta.servlet.http.Part;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.io.*;

import static processing.ImageProcessing.extractBytes;


class ImageProcessingTest {

    @Test
    void extractBytesTest() throws IOException {
        String[] imagePaths =
                {
                        "src/test/java/processing/2.jpg",
                        "src/test/java/processing/3.jpg",
                        "src/test/java/processing/4.jpg",
                        "src/test/java/processing/5.jpg",
                        "src/test/java/processing/6.jpg",
                        "src/test/java/processing/7.jpg",
                        "src/test/java/processing/ezgif-2-d1850fad73.jpg",
                        "src/test/java/processing/niederkaiserkamm-14871-0.jpg",
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
            picture.setPicture(test);
            picture.setInUse(false);
            PictureBroker p = new PictureBroker();
            Picture picture1 = (Picture) p.save(picture);

        }
    }

}