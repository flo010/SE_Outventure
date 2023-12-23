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

    public void removePOIFromHike(int poiID, int hikeID) {
        EntityManager entityManager = getEntityManager();
        try {
            entityManager.getTransaction().begin();
            Query query = entityManager.createNativeQuery("DELETE FROM poi_on_hike WHERE poi = ? AND hike = ?");
            query.setParameter(1, poiID);
            query.setParameter(2, hikeID);
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
