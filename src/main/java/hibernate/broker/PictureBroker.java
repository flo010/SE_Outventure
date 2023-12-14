package hibernate.broker;

import hibernate.model.Picture;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;

import java.util.List;
import java.util.UUID;

public class PictureBroker extends BrokerBase<Picture> {

    public Picture getLazy(String value) {
        value += "::uuid";
        EntityManager entityManager = getEntityManager();
        Query query = entityManager.createQuery("SELECT p FROM Picture p WHERE p.pictureID = :pictureID");
        query.setParameter("pictureID", value);
        Picture picture = (Picture) query.getSingleResult();
        entityManager.close();

        return picture;
    }

    @Override
    public Picture getLazy(int value) {
        return null;
    }

    @Override
    public List<Picture> getAll() {
        EntityManager entityManager = getEntityManager();
        List<Picture> pictures = entityManager.createQuery("SELECT p FROM Picture p", Picture.class).getResultList();
        entityManager.close();

        return pictures;
    }

    public Picture getNewPicture(){
        EntityManager entityManager = getEntityManager();
        Query query = entityManager.createQuery("SELECT p FROM Picture p WHERE p.inUse =: inUse");
        query.setParameter("inUse", true);
        Picture picture = (Picture) query.getSingleResult();
        entityManager.close();

        return picture;
    }
}
