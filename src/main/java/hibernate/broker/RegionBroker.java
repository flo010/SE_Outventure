package hibernate.broker;

import hibernate.model.Hike;
import hibernate.model.Region;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;

import java.util.List;

public class RegionBroker extends BrokerBase {
    @Override
    public Region getLazy(int value) {
        EntityManager entityManager = getEntityManager();
        Query query = entityManager.createQuery("SELECT r FROM Region r WHERE regionID =: regionID");
        query.setParameter("regionID", value);
        Region region = (Region) query.getSingleResult();
        entityManager.close();

        return region;
    }

    @Override
    public List getAll() {
        EntityManager entityManager = null;
        try {
            entityManager = getEntityManager();
        } catch (Exception f){
            System.out.println("no entityManager");
        }

        List<Region> regions = null;

        try {
            if (entityManager != null && entityManager.isOpen()) {
                regions = entityManager.createQuery("SELECT r FROM Region r", Region.class).getResultList();
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

        return regions;
    }

    public Region getByName(String regionName) {
        EntityManager entityManager = getEntityManager();
        Query query = entityManager.createQuery("SELECT r FROM Region r WHERE region =: name");
        query.setParameter("name", regionName);
        Region region = (Region) query.getSingleResult();
        entityManager.close();

        return region;
    }
    public List<Hike> getHikesByRegionName(String regionName) {
        EntityManager entityManager = getEntityManager();
        Query query = entityManager.createQuery(
                "SELECT h FROM Hike h " +
                        "JOIN h.region r " +
                        "WHERE LOWER(r.region) LIKE LOWER(:regionName)");

        query.setParameter("regionName", "%" + regionName + "%");

        List<Hike> hikes = query.getResultList();
        entityManager.close();

        return hikes;
    }


}
