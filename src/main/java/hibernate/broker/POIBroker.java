package hibernate.broker;

import hibernate.model.Hike;
import hibernate.model.PointOfInterest;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;

import java.util.ArrayList;
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
    public List<Hike> getByNameLazy(String poiName) {
        EntityManager entityManager = getEntityManager();
        Query query = entityManager.createNativeQuery(
                "SELECT * FROM hikes h " +
                        "LEFT JOIN poi_on_hike poh ON h.hike_id = poh.hike " +
                        "LEFT JOIN points_of_interest poi ON poh.poi = poi.poi_id " +
                        "WHERE poi.name = :poiName");

        query.setParameter("poiName", poiName);

        List<Object[]> result = query.getResultList();
        List<Hike> hikes = new ArrayList<>();
        for (Object[] row : result) {

            Hike hike = new Hike();
            hike.setHikeID((int) row[0]);
            hike.setPreviewPicture((String) row[1]);
            hike.setTitle((String) row[2]);
            hike.setDescription((String) row[3]);
            hike.setDuration((double) row[4]);
            hike.setDistance((double) row[5]);
            hike.setAltitude((int) row[6]);
            //hike.setStart((Integer) row[7]);
            //hike.setDestination((Destination) row[8]);
            hike.setStrength((int) row[9]);
            hike.setStamina((int) row[10]);
            hike.setExperience((int) row[11]);
            hike.setLandscape((int) row[12]);
            hike.setJanuary((boolean) row[13]);hike.setFebruary((boolean) row[14]);hike.setMarch((boolean) row[15]);hike.setApril((boolean) row[16]);hike.setMay((boolean) row[17]);hike.setJune((boolean) row[18]);hike.setJuly((boolean) row[19]);hike.setAugust((boolean) row[20]);hike.setSeptember((boolean) row[21]);hike.setOctober((boolean) row[22]);hike.setNovember((boolean) row[23]);hike.setDecember((boolean) row[24]);
            hike.setRouteDescription((String) row[25]);
            hike.setParkingInformation((String) row[26]);
            hike.setArrivalInformation((String) row[27]);
            hike.setAuthor((String) row[28]);
            //hike.setDate((LocalDate) row[29]);
            hike.setVisible((boolean) row[30]);
            //hike.setRegion((Region) row[31]);

            hikes.add(hike);
        }
        entityManager.close();
        return hikes;
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
