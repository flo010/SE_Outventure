package hibernate.broker;

import hibernate.model.Hike;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;

import java.util.List;

public class HikeBroker extends BrokerBase<Hike> {
    @Override
    public Hike get(int value) {
        EntityManager entityManager = getEntityManager();
        Query query = entityManager.createQuery("SELECT h FROM Hike h WHERE hikeID =: hikeID");
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
        System.out.println(hb.get(1).getStart().getName());
    }
}

