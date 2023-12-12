package hibernate.broker;

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

    public void addGpxFile(String gpxContent) {
        EntityManager entityManager = getEntityManager();
        try {
            entityManager.getTransaction().begin();

            gpxData gpxDataEntity = new gpxData();

            try {
                gpxDataEntity.setGpxContent(gpxContent);
            } catch (Exception e){

                e.printStackTrace();
                throw new IllegalArgumentException("GPX content cannot be null");
            }
            // Persist the entity to the database
            entityManager.persist(gpxDataEntity);

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

