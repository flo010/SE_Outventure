import hibernate.model.Hike;
import org.junit.jupiter.api.Test;
import servlets.user_management.PerformanceStatisticsServlet;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.mock;

class PerformanceStatisticsServletTest {

    @Test
    void calculateValues() {
        List<Hike> filteredHikes = new ArrayList<>();

        mock(Hike.class);
        Hike mockedHike1 = new Hike();
        mockedHike1.setHikeID(1);
        mockedHike1.setTitle("Title Mocked Hike 1");
        mockedHike1.setDistance(1.3);
        mockedHike1.setDuration(1.0);
        mockedHike1.setAltitude(1);
        mockedHike1.setVisible(true);

        Hike mockedHike2 = new Hike();
        mockedHike2.setHikeID(2);
        mockedHike2.setTitle("Title Mocked Hike 2");
        mockedHike2.setDistance(2.0);
        mockedHike2.setDuration(1.2);
        mockedHike2.setAltitude(2);
        mockedHike2.setVisible(true);

        filteredHikes.add(mockedHike1);
        filteredHikes.add(mockedHike2);

        PerformanceStatisticsServlet performanceStatisticsServlet = new PerformanceStatisticsServlet();
        double[] calculatedValues = performanceStatisticsServlet.calculateValues(filteredHikes);

        assertEquals(3.3, calculatedValues[0]);
        assertEquals(2.2, calculatedValues[1]);
        assertEquals(3, (int) calculatedValues[2]);
    }
}