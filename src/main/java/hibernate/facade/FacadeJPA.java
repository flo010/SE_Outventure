package hibernate.facade;

import hibernate.broker.HikeBroker;
import hibernate.broker.PictureBroker;
import hibernate.model.Hike;
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

    public Picture getNewPicture(){
        PictureBroker pictureBroker = new PictureBroker();

        return pictureBroker.getNewPicture();
    }
}
