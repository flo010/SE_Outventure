package Facade;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

public class JPAFacade implements Facade{
    @Override
    public void insert(Object hike) {
        new HikeBroker().insert((Hike)hike);
    }

    @Override
    public void delete(Object hike) {

        EntityManager entityManager = getEntityManager();
        EntityTransaction entityTransaction = entityManager.getTransaction();
        entityTransaction.begin();
        entityManager.remove((Hike)hike);
        entityTransaction.commit();
    }

    @Override
    public Hike getAllHikesByID() {
        HikeBroker hikeBroker = new HikeBroker();
        return hikeBroker.getAll();
    }

    @Override
    public Hike getHikeByID(int hikeID) {
        HikeBroker hikeBroker = new HikeBroker();
        return hikeBroker.getByID(hikeID);
    }
}
