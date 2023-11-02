package hibernate.broker;

import hibernate.model.Hike;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;

import java.util.List;

public class HikeBroker extends BrokerBase<Hike> {
    @Override
    public Hike get(int value) {
        EntityManager entityManager = getEntityManager();
        Query query = entityManager.createQuery("SELECT h FROM Hike h WHERE _hikeID =: hikeID");
        query.setParameter("hikeID", value);
        Hike hike = (Hike) query.getSingleResult();
        entityManager.close();

        return hike;
    }

    @Override
    public List<Hike> getAll() {
        EntityManager entityManager = getEntityManager();
        List<Hike> hikes = (List<Hike>) entityManager.createQuery("SELECT h FROM Hike h", Hike.class).getResultList();
        entityManager.close();

        return hikes;
    }

    public static void main(String[] args) {
        HikeBroker hb = new HikeBroker();
        List<Hike> hikes = hb.getAll();
        for (Hike h: hikes){
            System.out.println(h.getTitle());
        }
        System.out.println("\n");
        System.out.println(hb.get(3).getTitle());
    }
}

