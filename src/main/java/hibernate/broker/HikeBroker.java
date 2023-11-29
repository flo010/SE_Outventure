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

    public List<Hike> getByTitle(String title) {
        EntityManager entityManager = null;
        try {
            entityManager = getEntityManager();
        } catch (Exception f){
            System.out.println("no entityManager");
        }

        List<Hike> hikes = null;

        try {
            if (entityManager != null && entityManager.isOpen()) {
                Query query = entityManager.createQuery("SELECT h FROM Hike h WHERE LOWER(h.title) LIKE LOWER(:title)");
                query.setParameter("title", "%" + title + "%");
                hikes = query.getResultList();

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

    public List<Hike> search(String title,int durationLow,int durationHigh, int strengthLow,
                             int strengthHigh, int staminaLow,int staminaHigh,
                             int experienceLow, int experienceHigh, int landscapeLow,
                             int landscapeHigh, int distanceLow, int distanceHigh,
                             int altitudeLow, int altitudeHigh, boolean january,
                             boolean february, boolean march, boolean april,
                             boolean may, boolean june, boolean july,
                             boolean august, boolean september,
                             boolean october, boolean november, boolean december) {
        EntityManager entityManager = null;
        try {
            entityManager = getEntityManager();
        } catch (Exception f){
            System.out.println("no entityManager");
        }

        List<Hike> hikes = null;

        try {
            if (entityManager != null && entityManager.isOpen()) {
                Query query = entityManager.createQuery("" +
                                "SELECT h FROM Hike h WHERE LOWER(h.title) LIKE LOWER(:title)" +
                                "AND h.duration > (:durationLow) AND h.duration < (:durationHigh)" +
                                "AND h.strength > (:strengthLow) AND h.strength < (:strengthHigh)" +
                                "AND h.stamina >(:staminaLow) AND h.stamina < (:staminaHigh)" +
                                "AND h.experience > (:experienceLow) AND h.strength < (:experienceHigh)" +
                                "AND h.landscape > (:landscapeLow) AND h.landscape < (:landscapeHigh)" +
                                "AND h.distance > (:distanceLow) AND h.distance < (:distanceHigh)" +
                                "AND h.altitude > (:altitudeLow) AND h.altitude < (:altitudeHigh)" +
                                "AND h.january = (:january)" +
                                "AND h.february = (:february)" +
                                "AND h.march = (:march)" +
                                "AND h.april = (:april)" +
                                "AND h.may = (:may)" +
                                "AND h.june = (:june)" +
                                "AND h.july = (:july)" +
                                "AND h.august = (:august)" +
                                "AND h.september = (:september)" +
                                "AND h.october = (:october)" +
                                "AND h.november = (:november)" +
                                "AND h.december = (:december)");
                query.setParameter("title", "%" + title + "%");
                query.setParameter("durationLow", durationLow);
                query.setParameter("durationHigh", durationHigh);
                query.setParameter("strengthLow", strengthLow);
                query.setParameter("strengthHigh", strengthHigh);
                query.setParameter("staminaLow", staminaLow);
                query.setParameter("staminaHigh", staminaHigh);
                query.setParameter("experienceLow", experienceLow);
                query.setParameter("experienceHigh", experienceHigh);
                query.setParameter("landscapeLow", landscapeLow);
                query.setParameter("landscapeHigh", landscapeHigh);
                query.setParameter("distanceLow", distanceLow);
                query.setParameter("distanceHigh", distanceHigh);
                query.setParameter("altitudeLow", altitudeLow);
                query.setParameter("altitudeHigh", altitudeHigh);
                query.setParameter("january", january);
                query.setParameter("february", february);
                query.setParameter("march", march);
                query.setParameter("april", april);
                query.setParameter("may", may);
                query.setParameter("june", june);
                query.setParameter("july", july);
                query.setParameter("august", august);
                query.setParameter("september", september);
                query.setParameter("october", october);
                query.setParameter("november", november);
                query.setParameter("december", december);
                hikes = query.getResultList();

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
}


