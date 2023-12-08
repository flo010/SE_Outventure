package hibernate.facade;

import hibernate.broker.HikeBroker;
import hibernate.broker.HikerBroker;
import hibernate.broker.PictureBroker;
import hibernate.model.Hike;
import hibernate.model.Hiker;
import hibernate.model.Picture;


import java.util.List;

public class FacadeJPA implements Facade {
    private static FacadeJPA _instance;

    private FacadeJPA() {}

    public static FacadeJPA getInstance() {
        if (_instance == null) {
            _instance = new FacadeJPA();
        }
        return _instance;
    }

    @Override
    public Object save(Object object) {
        if (object instanceof Hike) {
            HikeBroker hikeBroker = new HikeBroker();
            hikeBroker.save((Hike) object);
            return object;
        }
        else if (object instanceof Picture) {
            PictureBroker pictureBroker = new PictureBroker();
            pictureBroker.save((Picture) object);
            return object;
        }
        return null;
    }

    @Override
    public void delete(Object object) {
        if (object instanceof Hike) {
            HikeBroker hikeBroker = new HikeBroker();
            hikeBroker.delete((Hike) object);
        } else if (object instanceof Picture) {
            PictureBroker pictureBroker = new PictureBroker();
            pictureBroker.delete((Picture) object);
        }
    }

    @Override
    public Hike getHikeByIDLazy(int hikeID) {
        HikeBroker hikeBroker = new HikeBroker();

        return hikeBroker.getLazy(hikeID);
    }


    @Override
    public Hike getHikeByIDEager(int hikeID) {
        HikeBroker hikeBroker = new HikeBroker();

        return hikeBroker.getEager(hikeID);
    }

    @Override
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

    @Override
    public Picture getPictureByID(int pictureID) {
        PictureBroker pictureBroker = new PictureBroker();

        return pictureBroker.getLazy(pictureID);
    }

    @Override
    public List<Picture> getAllPictures() {
        PictureBroker pictureBroker = new PictureBroker();

        return pictureBroker.getAll();
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

    public String getUsernameByEmailAndPassword (String email, String password){
        HikerBroker hikerBroker = new HikerBroker();

        return hikerBroker.getUsernameByEmailAndPassword(email, password);
    }

    public boolean checkHikerCredentials(String email, String password) {
        HikerBroker hikerBroker = new HikerBroker();

        return hikerBroker.checkHikerLoginCredentials(email, password);
    }
}
