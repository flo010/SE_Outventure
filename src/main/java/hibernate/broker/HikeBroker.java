package hibernate.broker;

import hibernate.model.Hike;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;

import java.util.List;

public class HikeBroker extends BrokerBase<Hike> {
    @Override
    public Hike getLazy(int value) {
        EntityManager entityManager = getEntityManager();
        Query query = entityManager.createQuery("SELECT h FROM Hike h WHERE hikeID =: hikeID");
        query.setParameter("hikeID", value);
        Hike hike = (Hike) query.getSingleResult();
        entityManager.close();

        return hike;
    }

    public Hike getEager(int value) {
        EntityManager entityManager = getEntityManager();
        Query query = entityManager.createQuery("SELECT h FROM Hike h LEFT JOIN FETCH h.pointsOfInterest WHERE h.hikeID = :hikeID");
        query.setParameter("hikeID", value);
        Hike hike = (Hike) query.getSingleResult();
        entityManager.close();

        return hike;
    }

    @Override
    public List<Hike> getAll() {
        EntityManager entityManager = null;
        try {
            entityManager = getEntityManager();
        } catch (Exception f){
            System.out.println("no entityManager");
        }

        List<Hike> hikes = null;

        try {
            if (entityManager != null && entityManager.isOpen()) {
                hikes = entityManager.createQuery("SELECT h FROM Hike h", Hike.class).getResultList();
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

        return hikes;
    }

    public List<Hike> getByAuthor(String author) {
        EntityManager entityManager = null;
        try {
            entityManager = getEntityManager();
        } catch (Exception f){
            System.out.println("no entityManager");
        }

        List<Hike> hikes = null;

        try {
            if (entityManager != null && entityManager.isOpen()) {
                Query query = entityManager.createQuery("SELECT h FROM Hike h WHERE h.author = :author");
                query.setParameter("author", author);
                hikes = query.getResultList();

            } else {
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
        return hikes;
    }

}


