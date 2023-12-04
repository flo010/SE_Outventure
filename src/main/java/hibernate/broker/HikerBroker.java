package hibernate.broker;

import hibernate.model.Hiker;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;

import java.util.List;

public class HikerBroker extends BrokerBase<Hiker>{
    @Override
    public Hiker getLazy(int value) {
        return null;
    }

    @Override
    public List<Hiker> getAll() {
        return null;
    }

    public Hiker getHikerEmail(String email) {
        EntityManager entityManager = null;

        Hiker EMail = null;
        try {
            entityManager = getEntityManager();
            Query query = entityManager.createQuery("SELECT h FROM Hiker h WHERE h.email = :email", Hiker.class);

            EMail = (Hiker) query.setParameter("email", email);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (entityManager != null) {
                entityManager.close();
            }
        }
        return EMail;
    }
}
