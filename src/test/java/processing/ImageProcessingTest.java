package processing;

import hibernate.broker.PictureBroker;
import hibernate.model.Picture;
import jakarta.servlet.http.Part;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import servlets.hike.ImageServlet;

import java.io.*;
import java.util.Arrays;
import java.util.UUID;

import static processing.ImageProcessing.extractBytes;


class ImageProcessingTest {

    @Test
    void extractBytesTest() throws IOException {
        UUID[] predefinedUUIDs = {
                UUID.fromString("00000000-0000-0000-0000-000000000001"),
                UUID.fromString("00000000-0000-0000-0000-000000000002"),
                UUID.fromString("00000000-0000-0000-0000-000000000003"),
                UUID.fromString("00000000-0000-0000-0000-000000000004"),
                UUID.fromString("00000000-0000-0000-0000-000000000005"),
                UUID.fromString("00000000-0000-0000-0000-000000000006"),
                UUID.fromString("00000000-0000-0000-0000-000000000007"),
                UUID.fromString("00000000-0000-0000-0000-000000000008")
        };
        String[] imagePaths =
                {
                        "src/test/java/processing/2.jpg",
                        "src/test/java/processing/3.jpg",
                        "src/test/java/processing/4.jpg",
                        "src/test/java/processing/5.jpg",
                        "src/test/java/processing/6.jpg",
                        "src/test/java/processing/7.jpg",
                        "src/test/java/TestHikeImage.jpg",
                        "src/test/java/processing/niederkaiserkamm-14871-0.jpg",
                };

        for (int i = 0; i < 8; i++) {
            File file = new File(imagePaths[i]);
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
            picture.setPictureID(predefinedUUIDs[i].toString());
            PictureBroker p = new PictureBroker();
            p.save(picture);
        }

    }
    @Test
    void PictureInsert() throws IOException {
        UUID predefinedUUIDs = UUID.randomUUID();
        String imagePaths = "src/test/java/processing/2.jpg";



            File file = new File(imagePaths);
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
            System.out.println(Arrays.toString(test));
            Picture picture = new Picture();
            picture.setPicture(test);
            picture.setPictureID(predefinedUUIDs.toString());
            PictureBroker p = new PictureBroker();
            p.save(picture);
        }

    @Test
    void PictureInsertServletMethods() throws IOException {
        UUID predefinedUUIDs = UUID.randomUUID();
        String imagePaths = "src/test/java/processing/2.jpg";

        File file = new File(imagePaths);
        FileInputStream fileInputStream = new FileInputStream(file);

        // Create a MockPart and set necessary attributes
        Part mockPart = Mockito.mock(Part.class);
        Mockito.when(mockPart.getInputStream()).thenReturn(fileInputStream);
        Mockito.when(mockPart.getSubmittedFileName()).thenReturn(file.getName());
        Mockito.when(mockPart.getSize()).thenReturn(file.length());
        Mockito.when(mockPart.getHeader(Mockito.anyString())).thenReturn("image/jpeg"); // Change content type if needed
        Mockito.when(mockPart.getContentType()).thenReturn("image/jpeg"); // Change content type if needed
        Mockito.when(mockPart.getName()).thenReturn("file"); // Name of the input type for file upload
        ImageServlet test1 = new ImageServlet();
        byte[] test = test1.getBytesFromInputStream(fileInputStream);
        test1.saveToDatabase(test);
    }
    }
