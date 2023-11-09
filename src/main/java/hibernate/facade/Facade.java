package hibernate.facade;

import hibernate.model.Hike;
import hibernate.model.Picture;
import hibernate.model.PointOfInterest;

import java.util.List;

public interface Facade {
    // INSERT + UPDATE
    public void save(Object object);

    // DELETE
    public void delete(Object object);

    //READ
    public Hike getHikeByID(int hikeID);
    public List<Hike> getAllHikes();
    public Picture getPictureByID(int pictureID);
    public List<Picture> getAllPictures();

}
