package hibernate.broker;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.util.List;

public abstract class BrokerBase<T> {
    private static EntityManagerFactory _entityManagerFactory;

    private EntityManagerFactory getEntityManagerFactory(){
        if(_entityManagerFactory == null){
            _entityManagerFactory = Persistence.createEntityManagerFactory("Outventure");
        }
        return _entityManagerFactory;
    }
    public EntityManager getEntityManager() {
        EntityManager entityManager = null;
        try {
            EntityManagerFactory fact = getEntityManagerFactory();
            entityManager = fact.createEntityManager();
        } catch (Exception e) {
            System.out.println("Error creating EntityManager: " + e.getMessage());
        }
        return entityManager;
    }

    public Object save(T value) {
        EntityManager entityManager = getEntityManager();
        entityManager.getTransaction().begin();
        entityManager.merge(value);
        entityManager.getTransaction().commit();
        entityManager.close();
        return value;
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
