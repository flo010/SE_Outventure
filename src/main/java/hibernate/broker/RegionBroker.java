package hibernate.broker;

import hibernate.model.Hike;
import hibernate.model.Region;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;

import java.util.List;

public class RegionBroker extends BrokerBase<Region> {
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
    public List<Region> getAll() {
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
        String trimmedRegionName = regionName.trim();
        Query query = entityManager.createQuery("SELECT r FROM Region r WHERE r.region =: name");
        query.setParameter("name", trimmedRegionName);
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
