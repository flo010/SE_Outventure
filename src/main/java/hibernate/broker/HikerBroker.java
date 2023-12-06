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

    public boolean checkHikerLoginCredentials(String email, String password){

        try {
            EntityManager entityManager = getEntityManager();
            Query query = entityManager.createQuery("SELECT COUNT(h) FROM Hiker h WHERE h.email = :email AND h.password = :password");
            query.setParameter("email", email);
            query.setParameter("password", password);
            Long count = (Long) query.getSingleResult();

            return count > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
      return false;
    }

}
