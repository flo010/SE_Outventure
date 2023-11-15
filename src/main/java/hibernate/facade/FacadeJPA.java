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
        Hike hike = hikeBroker.getLazy(hikeID);

        return hike;
    }

    @Override
    public Hike getHikeByIDEager(int hikeID) {
        HikeBroker hikeBroker = new HikeBroker();
        Hike hike = hikeBroker.getEager(hikeID);

        return hike;
    }

    @Override
    public List<Hike> getAllHikes() {
        HikeBroker hikeBroker = null;
        hikeBroker = new HikeBroker();
        List<Hike> hikes = null;
        try {
            hikes = hikeBroker.getAll();
        } catch (Exception e) {
            System.out.println("getAllHikes is null");
        }


        return hikes;
    }

    @Override
    public Picture getPictureByID(int pictureID) {
        PictureBroker pictureBroker = new PictureBroker();
        Picture picture = pictureBroker.getLazy(pictureID);

        return picture;
    }

    @Override
    public List<Picture> getAllPictures() {
        PictureBroker pictureBroker = new PictureBroker();
        List<Picture> pictures = pictureBroker.getAll();

        return pictures;
    }
}
