package hibernate.broker;

import hibernate.model.Hike;
import hibernate.model.PointOfInterest;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;

import java.util.List;

public class POIBroker extends BrokerBase<PointOfInterest> {

    @Override
    public PointOfInterest getLazy(int value) {
        EntityManager entityManager = getEntityManager();
        Query query = entityManager.createQuery("SELECT poi FROM PointOfInterest poi WHERE poiID =: poiID");
        query.setParameter("poiID", value);
        PointOfInterest pointOfInterest = (PointOfInterest) query.getSingleResult();
        entityManager.close();

        return pointOfInterest;
    }

    @Override
    public List<PointOfInterest> getAll() {
        EntityManager entityManager = null;
        try {
            entityManager = getEntityManager();
        } catch (Exception f){
            System.out.println("no entityManager");
        }

        List<PointOfInterest> pointsOfInterest = null;

        try {
            if (entityManager != null && entityManager.isOpen()) {
                pointsOfInterest = entityManager.createQuery("SELECT poi FROM PointOfInterest poi", PointOfInterest.class).getResultList();
            } else {
                // Handle the situation when the EntityManager is closed
                System.out.println("EntityManager is closed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("entityManager is null");
        } finally {
            if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
            }
        }

        return pointsOfInterest;
    }
}
