package hibernate.facade;

import hibernate.model.Hike;
import hibernate.model.Picture;

import java.util.List;

public interface Facade {
    // INSERT + UPDATE
<<<<<<< HEAD
    void save(Object object);
=======
    Object save(Object object);
>>>>>>> BacktoSearch

    // DELETE
    void delete(Object object);

    //READ
    Hike getHikeByIDLazy(int hikeID);
    Hike getHikeByIDEager(int hikeID);
    List<Hike> getAllHikesLazy();
    Picture getPictureByID(int pictureID);
    List<Picture> getAllPictures();

}
