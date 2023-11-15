package hibernate.broker;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.util.List;

public abstract class BrokerBase<T> {

    public EntityManager getEntityManager() {
        EntityManager entityManager = null;
        try {
            EntityManagerFactory fact = Persistence.createEntityManagerFactory("Outventure");
            entityManager = fact.createEntityManager();
        } catch (Exception e) {
            System.out.println("classInfo is null");
        }
        return entityManager;
    }

    public void save(T value) {
        EntityManager entityManager = getEntityManager();
        entityManager.getTransaction().begin();
        entityManager.merge(value);
        entityManager.getTransaction().commit();
        entityManager.close();
    }

    public  void delete(T value) {
        EntityManager entityManager = getEntityManager();
        entityManager.getTransaction().begin();
        entityManager.remove(entityManager.contains(value) ? value : entityManager.merge(value));
        entityManager.getTransaction().commit();
        entityManager.close();
    }

    public abstract T getLazy(int value);

    public abstract List<T> getAll();
}
