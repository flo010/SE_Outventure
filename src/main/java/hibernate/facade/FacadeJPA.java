package hibernate.facade;

import hibernate.broker.*;
import hibernate.model.*;

import java.sql.Date;
import java.util.List;

public class FacadeJPA {
    private static FacadeJPA _instance;

    private FacadeJPA() {}

    public static FacadeJPA getInstance() {
        if (_instance == null) {
            _instance = new FacadeJPA();
        }
        return _instance;
    }

    public void save(Object object) {
        if (object instanceof Hike) {
            HikeBroker hikeBroker = new HikeBroker();
            hikeBroker.save((Hike) object);
        }
        else if (object instanceof Picture) {
            PictureBroker pictureBroker = new PictureBroker();
            pictureBroker.save((Picture) object);
        }
    }

    public void delete(Object object) {
        if (object instanceof Hike) {
            HikeBroker hikeBroker = new HikeBroker();
            hikeBroker.delete((Hike) object);
        } else if (object instanceof Picture) {
            PictureBroker pictureBroker = new PictureBroker();
            pictureBroker.delete((Picture) object);
        }
    }

    public Hike getHikeByIDLazy(int hikeID) {
        HikeBroker hikeBroker = new HikeBroker();

        return hikeBroker.getLazy(hikeID);
    }

    public Hike getHikeByIDEager(int hikeID) {
        HikeBroker hikeBroker = new HikeBroker();

        return hikeBroker.getEager(hikeID);
    }

    public List<Hike> getAllHikesLazy() {
        HikeBroker hikeBroker = new HikeBroker();
        List<Hike> hikes = null;
        try {
            hikes = hikeBroker.getAll();
            System.out.println(hikes.get(0).getTitle());
        } catch (Exception e) {
            System.out.println("getAllHikes is null");
        }

        return hikes;
    }

    public List<Hike> getHikesByTitleLazy(String title) {
        HikeBroker hikeBroker = new HikeBroker();
        List<Hike> hikes = null;
        try {
            hikes = hikeBroker.getByTitle(title);
        } catch (Exception e) {
            System.out.println("getAllHikes is null");
        }

        return hikes;
    }

    public Picture getPictureByID(String pictureID) {
        PictureBroker pictureBroker = new PictureBroker();

        return pictureBroker.getLazy(pictureID);
    }
    public PointOfInterest getPOIByID(int poiID) {
        POIBroker poiBroker = new POIBroker();

        return poiBroker.getLazy(poiID);
    }

    public List<PointOfInterest> getAllPOIs() {
        POIBroker poiBroker = new POIBroker();

        return poiBroker.getAll();
    }

    public void removePOIFromHike(int poiID, int hikeID) {
        POIBroker poiBroker = new POIBroker();
        poiBroker.removePOIFromHike(poiID, hikeID);
    }

    public List<Hike> search(String title,int durationLow,int durationHigh, int strengthLow,
                             int strengthHigh, int staminaLow,int staminaHigh,
                             int experienceLow, int experienceHigh, int landscapeLow,
                             int landscapeHigh, int distanceLow, int distanceHigh,
                             int altitudeLow, int altitudeHigh,int month) {
        HikeBroker hikeBroker = new HikeBroker();
        return hikeBroker.search(title,durationLow,durationHigh,
                strengthLow,strengthHigh,staminaLow,staminaHigh,experienceLow,
                experienceHigh,landscapeLow,landscapeHigh,distanceLow,distanceHigh,
                altitudeLow,altitudeHigh,month);
    }

    public Picture getNewPicture(){
        PictureBroker pictureBroker = new PictureBroker();

        return pictureBroker.getNewPicture();
    }

    public List<Hike> getHikesByAuthorLazy(String author) {
        HikeBroker hikeBroker = new HikeBroker();
        List<Hike> hikes = null;
        try {
            hikes = hikeBroker.getByAuthor(author);
        } catch (Exception e) {
            System.out.println("getAllHikes is null");
        }
        return hikes;
    }

    public boolean checkHikerCredentials(String email, String password) {
        HikerBroker hikerBroker = new HikerBroker();

        return hikerBroker.checkHikerLoginCredentials(email, password);
    }

    public Hiker getHikerByEmail(String email) {
        HikerBroker hikerBroker = new HikerBroker();

        return hikerBroker.getByEmail(email);
    }

    public Hiker getHikerByID(int id) {
        HikerBroker hikerBroker = new HikerBroker();

        return hikerBroker.getLazy(id);
    }

    public boolean isFavoriteHikeExists(int hikerId, int hikeId) {
        HikerBroker hikerBroker = new HikerBroker();
        return hikerBroker.isFavoriteHikeExists(hikerId, hikeId);
    }

    public void addFavoriteHike(int hikerId, int hikeId) {
        HikerBroker hikerBroker = new HikerBroker();
        hikerBroker.addFavoriteHike(hikerId, hikeId);
    }

    public void removeFavoriteHike(int hikerId, int hikeId) {
        HikerBroker hikerBroker = new HikerBroker();
        hikerBroker.removeFavoriteHike(hikerId, hikeId);
    }

    public void addCompletedHike(int hikerId, int hikeId, String timestamp) {
        HikerBroker hikerBroker = new HikerBroker();
        hikerBroker.addCompletedHike(hikerId, hikeId, timestamp);
    }

    public void removeCompletedHike(int hikeID, int hikerId, String timestamp) {
        HikerBroker hikerBroker = new HikerBroker();
        hikerBroker.removeCompletedHike(hikeID, hikerId, timestamp);
    }
    public Hike getHikeCommentByIDEager(int hikeID) {
        HikeBroker hikeBroker = new HikeBroker();

        return hikeBroker.getEagerComment(hikeID);
    }

    public void addComment(int hikeID, int hikerID, String comment) {
        HikeBroker hikeBroker = new HikeBroker();
        hikeBroker.addComment(hikeID, hikerID, comment);
    }

    public Region getRegionByID(int regionID) {
        RegionBroker regionBroker = new RegionBroker();
        return regionBroker.getLazy(regionID);
    }

    public List<Region> getAllRegions() {
        RegionBroker regionBroker = new RegionBroker();
        return regionBroker.getAll();
    }

    public Region getRegionByName(String regionName) {
        RegionBroker regionBroker = new RegionBroker();
        return regionBroker.getByName(regionName);
    }

    public List<Date> getCompletedHikesTimestamps(int hikerID) {
        HikerBroker hikerBroker = new HikerBroker();
        return hikerBroker.getTimestamps(hikerID);
    }
}

