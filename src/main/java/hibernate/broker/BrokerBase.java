package hibernate.broker;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.util.List;

public abstract class BrokerBase<T> {
    public EntityManager getEntityManager() {
        EntityManagerFactory fact = Persistence.createEntityManagerFactory("Outventure");
        EntityManager entityManager = fact.createEntityManager();

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

    public abstract T get(int value);

    public abstract List<T> getAll();
}
