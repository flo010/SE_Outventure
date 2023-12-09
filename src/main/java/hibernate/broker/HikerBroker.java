package hibernate.broker;

import hibernate.model.Hiker;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
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

    public Hiker getByEmail(String email) {
        try {
            EntityManager entityManager = getEntityManager();
            Query query = entityManager.createQuery("SELECT h FROM Hiker h WHERE h.email = :email");
            query.setParameter("email", email);
            Hiker hiker = (Hiker) query.getSingleResult();

            return hiker;
        } catch (NoResultException e) {
            // Handle case when no result is found (user not found or incorrect credentials)
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean isFavoriteHikeExists(int hikerId, int hikeId) {
        EntityManager entityManager = getEntityManager();

        try {
            Long count = (Long) entityManager.createNativeQuery(
                            "SELECT COUNT(*) FROM favorite_hikes WHERE hiker = ? AND hike = ?")
                    .setParameter(1, hikerId)
                    .setParameter(2, hikeId)
                    .getSingleResult();

            return count > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            entityManager.close();
        }
    }

    public void addFavoriteHike(int hikerId, int hikeId) {
        EntityManager entityManager = getEntityManager();
        try {
            Query query = entityManager.createNativeQuery("INSERT INTO favorite_hikes (hiker, hike) VALUES (?, ?)");
            query.setParameter(1, hikerId);
            query.setParameter(2, hikeId);
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

    public void removeFavoriteHike(int hikerId, int hikeId) {
        EntityManager entityManager = getEntityManager();

        try {
            entityManager.getTransaction().begin();
            Query query = entityManager.createNativeQuery("DELETE FROM favorite_hikes WHERE hiker = ? AND hike = ?");
            query.setParameter(1, hikerId);
            query.setParameter(2, hikeId);
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
