package hibernate.broker;

import hibernate.model.Hike;
import hibernate.model.gpxData;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;

import java.util.List;

public class gpxDataBroker extends BrokerBase<gpxData>{
    @Override
    public gpxData getLazy(int value) {
        return null;
    }

    @Override
    public List<gpxData> getAll() {
        return null;
    }

    public void addGpxFile(String hike, String gpxContent) {
        EntityManager entityManager = getEntityManager();
        try {
            entityManager.getTransaction().begin();
            Query query = entityManager.createNativeQuery("INSERT INTO gpx_data (hike_id, gpx_content) VALUES (?, ?)");
            query.setParameter(1, hike);
            query.setParameter(2, gpxContent);
            query.executeUpdate();

            entityManager.getTransaction().commit();
        } catch (Exception e) {
            if (entityManager.getTransaction().isActive()) {
                entityManager.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
    }

}

