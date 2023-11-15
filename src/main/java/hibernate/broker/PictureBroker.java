package hibernate.broker;

import hibernate.model.Picture;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;

import java.util.List;

public class PictureBroker extends BrokerBase<Picture> {
    @Override
    public Picture getLazy(int value) {
        EntityManager entityManager = getEntityManager();
        Query query = entityManager.createQuery("SELECT p FROM Picture p WHERE pictureID =: pictureID");
        query.setParameter("pictureID", value);
        Picture picture = (Picture) query.getSingleResult();
        entityManager.close();

        return picture;
    }

    @Override
    public List<Picture> getAll() {
        EntityManager entityManager = getEntityManager();
        List<Picture> pictures = (List<Picture>) entityManager.createQuery("SELECT p FROM Picture p", Picture.class).getResultList();
        entityManager.close();

        return pictures;
    }
}
