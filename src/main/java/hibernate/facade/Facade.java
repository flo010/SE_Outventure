package hibernate.facade;

import hibernate.model.Hike;
import hibernate.model.Hiker;
import hibernate.model.Picture;

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
    Picture getPictureByID(int pictureID);
    List<Picture> getAllPictures();
    Hiker getHikerEmail(String email);
    String getPasswordByEmail(String email);

}
