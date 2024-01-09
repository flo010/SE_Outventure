package servlets;

import hibernate.facade.FacadeJPA;
import hibernate.model.*;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import static org.mockito.Mockito.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebListener
public class MockListenerServlet implements ServletContextListener {

    public void contextInitialized(ServletContextEvent event) {
        String mockIt = System.getenv("MOCK");
        System.out.println("STARTED");

        if (mockIt != null) {
            FacadeJPA mockedFacade = mock(FacadeJPA.class);

            List<Hike> mockedHikes = new ArrayList<>();

            mock(Start.class);
            Start mockedStart = new Start();
            mockedStart.setStartID(1);
            mockedStart.setName("Name Mocked Start");
            mockedStart.setLatitude(47.458601);
            mockedStart.setLongitude(9.772524);

            mock(Destination.class);
            Destination mockedDestination = new Destination();
            mockedDestination.setDestinationID(1);
            mockedDestination.setName("Name Mocked Start");
            mockedDestination.setLatitude(47.463326);
            mockedDestination.setLongitude(9.808644);

            mock(Region.class);
            Region mockedRegion = new Region();
            mockedRegion.setRegionID(1);
            mockedRegion.setRegion("Vorarlberg");

            mock(Picture.class);
            Picture mockedPicture = new Picture();
            mockedPicture.setPictureID("688f2b13-6a75-4243-b9cf-7a87a9d56bb0");

            mock(Hike.class);
            Hike mockedHike1 = new Hike();
            mockedHike1.setHikeID(1);
            mockedHike1.setTitle("Title Mocked Hike 1");
            mockedHike1.setPreviewPicture("688f2b13-6a75-4243-b9cf-7a87a9d56bb0");
            mockedHike1.setDescription("Description Mocked Hike 1");
            mockedHike1.setDuration(1.0);
            mockedHike1.setDistance(1.0);
            mockedHike1.setAltitude(1);
            mockedHike1.setStart(mockedStart);
            mockedHike1.setDestination(mockedDestination);
            mockedHike1.setStrength(1);
            mockedHike1.setStamina(1);
            mockedHike1.setExperience(1);
            mockedHike1.setLandscape(1);
            mockedHike1.setJanuary(true);
            mockedHike1.setFebruary(false);
            mockedHike1.setMarch(false);
            mockedHike1.setApril(false);
            mockedHike1.setMay(false);
            mockedHike1.setJune(false);
            mockedHike1.setJuly(false);
            mockedHike1.setAugust(false);
            mockedHike1.setSeptember(false);
            mockedHike1.setOctober(false);
            mockedHike1.setNovember(false);
            mockedHike1.setDecember(false);
            mockedHike1.setRouteDescription("Route Description Mocked Hike 1");
            mockedHike1.setAuthor("mariannesadventure12");
            mockedHike1.setDate(LocalDate.now());
            mockedHike1.setVisible(true);
            mockedHike1.setRegion(mockedRegion);

            Hike mockedHike2 = new Hike();
            mockedHike2.setHikeID(1);
            mockedHike2.setTitle("Title Mocked Hike 1");
            mockedHike2.setPreviewPicture("688f2b13-6a75-4243-b9cf-7a87a9d56bb0");
            mockedHike2.setDescription("Description Mocked Hike 1");
            mockedHike2.setDuration(2.0);
            mockedHike2.setDistance(2.0);
            mockedHike2.setAltitude(2);
            mockedHike2.setStart(mockedStart);
            mockedHike2.setDestination(mockedDestination);
            mockedHike2.setStrength(2);
            mockedHike2.setStamina(2);
            mockedHike2.setExperience(2);
            mockedHike2.setLandscape(2);
            mockedHike2.setJanuary(false);
            mockedHike2.setFebruary(true);
            mockedHike2.setMarch(false);
            mockedHike2.setApril(false);
            mockedHike2.setMay(false);
            mockedHike2.setJune(false);
            mockedHike2.setJuly(false);
            mockedHike2.setAugust(false);
            mockedHike2.setSeptember(false);
            mockedHike2.setOctober(false);
            mockedHike2.setNovember(false);
            mockedHike2.setDecember(false);
            mockedHike2.setRouteDescription("Route Description Mocked Hike 1");
            mockedHike2.setAuthor("mariannesadventure12");
            mockedHike2.setDate(LocalDate.now());
            mockedHike2.setVisible(true);
            mockedHike2.setRegion(mockedRegion);

            mockedHikes.add(mockedHike1);
            mockedHikes.add(mockedHike2);

            mock(Hiker.class);
            Hiker mockedHiker = new Hiker();
            mockedHiker.setHikerID(1);
            mockedHiker.setUsername("mockedHiker");
            mockedHiker.setEmail("mocked.hiker@gmail.com");
            mockedHiker.setPassword("mockedPassword");

            mock(Comment.class);
            Comment mockedComment = new Comment();
            mockedComment.setCommentID(1);
            mockedComment.setHike(mockedHike1);
            mockedComment.setHiker(mockedHiker);
            mockedComment.setCommentText("Mocked Hike Comment");
            mockedComment.setTimestamp(LocalDate.now());

            List<Comment> mockedComments = new ArrayList<>();
            mockedComments.add(mockedComment);
            mockedHike1.setComments(mockedComments);

            mock(PointOfInterest.class);
            PointOfInterest poi = new PointOfInterest();
            poi.setPoiID(1);
            poi.setName("Mocked POI");
            poi.setLatitude(47.458720);
            poi.setLongitude(9.772641);
            poi.setType("Hut");
            poi.setHikes(mockedHikes);

            List<PointOfInterest> mockedPointsOfInterest = new ArrayList<>();
            mockedHike1.setPointsOfInterest(mockedPointsOfInterest);

            CommentServlet.facadeJPA = mockedFacade;
            CompletedHikeServlet.facadeJPA = mockedFacade;
            CreateHikeServlet.facadeJPA = mockedFacade;
            DeleteHikeServlet.facadeJPA = mockedFacade;
            DeletePOIServlet.facadeJPA = mockedFacade;
            FavoriteHikeServlet.facadeJPA = mockedFacade;
            HikeDetailServlet.facadeJPA = mockedFacade;
            ImageServlet.facadeJPA = mockedFacade;
            LoginServlet.facadeJPA = mockedFacade;
            SaveDataServlet.facadeJPA = mockedFacade;
            SearchResultsServlet.facadeJPA = mockedFacade;
            SearchServlet.facadeJPA = mockedFacade;
            ListCreatedHikesServlet.facadeJPA = mockedFacade;

            doNothing().when(mockedFacade).save(any(String.class));
            when(mockedFacade.getHikeByIDLazy(any(Integer.class))).thenReturn(mockedHike1);
            when(mockedFacade.getHikeByIDEager(any(Integer.class))).thenReturn(mockedHike1);
            when(mockedFacade.getHikeCommentByIDEager(any(Integer.class))).thenReturn(mockedHike1);
            when(mockedFacade.getAllHikesLazy()).thenReturn(mockedHikes);
            when(mockedFacade.getHikesByTitleLazy(any(String.class))).thenReturn(mockedHikes);
            when(mockedFacade.getHikesByAuthorLazy(any(String.class))).thenReturn(mockedHikes);
            when(mockedFacade.getPictureByID(any(String.class))).thenReturn(mockedPicture);
            doNothing().when(mockedFacade).removePOIFromHike(any(Integer.class), any(Integer.class));
            when(mockedFacade.search(any(String.class), any(Integer.class), any(Integer.class),
                    any(Integer.class), any(Integer.class), any(Integer.class),
                    any(Integer.class), any(Integer.class), any(Integer.class),
                    any(Integer.class), any(Integer.class), any(Integer.class),
                    any(Integer.class), any(Integer.class), any(Integer.class),
                    any(Integer.class))).thenReturn(mockedHikes);
            when(mockedFacade.checkHikerCredentials(any(String.class), any(String.class))).thenReturn(true);
            when(mockedFacade.getHikerByEmail(any(String.class))).thenReturn(mockedHiker);
            when(mockedFacade.getHikerByID(any(Integer.class))).thenReturn(mockedHiker);
            when(mockedFacade.isFavoriteHikeExists(any(Integer.class), any(Integer.class))).thenReturn(true);
            doNothing().when(mockedFacade).addFavoriteHike(any(Integer.class), any(Integer.class));
            doNothing().when(mockedFacade).removeFavoriteHike(any(Integer.class), any(Integer.class));
            doNothing().when(mockedFacade).addCompletedHike(any(Integer.class), any(Integer.class), any(String.class));
            doNothing().when(mockedFacade).removeCompletedHike(any(Integer.class), any(Integer.class), any(String.class));
//            doNothing().when(mockedFacade).addGpxFile(any(String.class), any(String.class));
            doNothing().when(mockedFacade).addComment(any(Integer.class), any(Integer.class), any(String.class));
        }
    }
}