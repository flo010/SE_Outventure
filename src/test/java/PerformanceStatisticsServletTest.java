import hibernate.facade.FacadeJPA;
import hibernate.model.Hike;
import hibernate.model.Hiker;
import org.junit.Test;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static org.mockito.Mockito.mock;

public class PerformanceStatisticsServletTest {
    @Test
    public void testDoPost() throws Exception {
        mock(Hiker.class);
        Hiker mockedHiker = new Hiker();
        mockedHiker.setHikerID(1);
        mockedHiker.setUsername("mockedHiker");
        mockedHiker.setEmail("mocked.hiker@gmail.com");
        mockedHiker.setPassword("mockedPassword");

        List<Hike> completedHikes = new ArrayList<>();
        List<Date> timestamps = new ArrayList<>();

        mock(Hike.class);
        Hike mockedHike1 = new Hike();
        mockedHike1.setHikeID(1);
        mockedHike1.setTitle("Title Mocked Hike 1");
        mockedHike1.setDuration(1.0);
        mockedHike1.setDistance(1.0);
        mockedHike1.setAltitude(1);
        mockedHike1.setVisible(true);

        Hike mockedHike2 = new Hike();
        mockedHike2.setHikeID(2);
        mockedHike2.setTitle("Title Mocked Hike 2");
        mockedHike2.setDuration(2.0);
        mockedHike2.setDistance(2.0);
        mockedHike2.setAltitude(2);
        mockedHike2.setVisible(true);

        completedHikes.add(mockedHike1);
        completedHikes.add(mockedHike2);
        String fromDateStr = "01-01-2024";
        String toDateStr = "02-01-2024";
        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
        Date fromDate = formatter.parse(fromDateStr);
        Date toDate = formatter.parse(toDateStr);
        timestamps.add(fromDate);
        timestamps.add(toDate);

//        when(session.getAttribute("hikerID")).thenReturn(hikerID);
//        when(facadeJPA.getHikerByID(hikerID)).thenReturn(mockedHiker);
//        when(mockedHiker.getCompletedHikes()).thenReturn(completedHikes);
//        when(facadeJPA.getCompletedHikesTimestamps(hikerID)).thenReturn(timestamps);
//
//        // Set up request parameters
//        when(request.getParameter("fromDate")).thenReturn("2024-01-01");
//        when(request.getParameter("toDate")).thenReturn("2024-01-03");
//
//        // Invoke doPost method
//        servlet.doPost(request, response);
//
//        // Verify session attributes
//        verify(session).setAttribute("filteredHikes", completedHikes);
//        verify(session).setAttribute("totalDistance", 25.0); // 10.0 + 15.0
//        verify(session).setAttribute("totalDuration", 150.0); // 60.0 + 90.0
//        verify(session).setAttribute("totalAltitude", 250); // 100 + 150
//        verify(session).setAttribute("fromDate", Date.valueOf("2024-01-01"));
//        verify(session).setAttribute("toDate", Date.valueOf("2024-01-03"));
//        verify(session).setAttribute("empty", false);
//
//        // Assertions
//        assertEquals(completedHikes, session.getAttribute("filteredHikes"));
//        assertEquals(25.0, (double) session.getAttribute("totalDistance"));
//        assertEquals(150.0, (double) session.getAttribute("totalDuration"));
//        assertEquals(250, (int) session.getAttribute("totalAltitude"));
//        assertEquals(Date.valueOf("2024-01-01"), session.getAttribute("fromDate"));
//        assertEquals(Date.valueOf("2024-01-03"), session.getAttribute("toDate"));
//        assertFalse((boolean) session.getAttribute("empty"));
    }
}
