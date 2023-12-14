package hibernate.facade;

import hibernate.model.Hike;
import hibernate.model.Picture;
import hibernate.model.PointOfInterest;

import java.util.List;

public interface Facade {
    // INSERT + UPDATE
    Object save(Object object);

    // DELETE
    void delete(Object object);

    //READ
    Hike getHikeByIDLazy(int hikeID);
    Hike getHikeByIDEager(int hikeID);
    List<Hike> getAllHikesLazy();

    Picture getPictureByID(String pictureID);


    PointOfInterest getPOIByID(int poiID);
    List<PointOfInterest> getAllPOIs();
}
