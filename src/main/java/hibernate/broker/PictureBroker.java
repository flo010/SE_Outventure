package hibernate.broker;

import hibernate.model.Picture;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;

import java.util.List;

public class PictureBroker extends BrokerBase<Picture> {
    @Override
    public void save(Picture value) {

        EntityManager entityManager = getEntityManager();
        entityManager.getTransaction().begin();
        entityManager.merge(value);
        entityManager.getTransaction().commit();
        entityManager.close();
    }
    public Picture getLazy(String value) {
        EntityManager entityManager = getEntityManager();
        Query query = entityManager.createQuery("SELECT p FROM Picture p WHERE cast(p.pictureID as string) = :pictureID");
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
}
