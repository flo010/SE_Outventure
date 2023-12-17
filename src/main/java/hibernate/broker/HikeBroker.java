package hibernate.broker;

import hibernate.model.Hike;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Predicate;
import jakarta.persistence.criteria.Root;

import java.util.ArrayList;
import java.util.List;

public class HikeBroker extends BrokerBase<Hike> {
    @Override
    public Hike getLazy(int value) {
        EntityManager entityManager = getEntityManager();
        Query query = entityManager.createQuery("SELECT h FROM Hike h WHERE hikeID =: hikeID");
        query.setParameter("hikeID", value);
        Hike hike = (Hike) query.getSingleResult();
        entityManager.close();

        return hike;
    }

    public Hike getEager(int value) {
        EntityManager entityManager = getEntityManager();
        Query query = entityManager.createQuery("SELECT DISTINCT h FROM Hike h LEFT JOIN FETCH h.pointsOfInterest LEFT JOIN FETCH h.region WHERE h.hikeID = :hikeID");
        query.setParameter("hikeID", value);
        Hike hike = (Hike) query.getSingleResult();
        entityManager.close();

        return hike;
    }

    @Override
    public List<Hike> getAll() {
        EntityManager entityManager = null;
        try {
            entityManager = getEntityManager();
        } catch (Exception f){
            System.out.println("no entityManager");
        }

        List<Hike> hikes = null;

        try {
            if (entityManager != null && entityManager.isOpen()) {
                hikes = entityManager.createQuery("SELECT h FROM Hike h", Hike.class).getResultList();
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

        return hikes;
    }
    public List<Hike> getByAuthor(String author) {
        EntityManager entityManager = null;
        try {
            entityManager = getEntityManager();
        } catch (Exception f){
            System.out.println("no entityManager");
        }

        List<Hike> hikes = null;

        try {
            if (entityManager != null && entityManager.isOpen()) {
                Query query = entityManager.createQuery("SELECT h FROM Hike h WHERE h.author = :author");
                query.setParameter("author", author);
                hikes = query.getResultList();

            } else {
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
        return hikes;
    }

    public List<Hike> getByTitle(String title) {
        EntityManager entityManager = null;
        try {
            entityManager = getEntityManager();
        } catch (Exception f){
            System.out.println("no entityManager");
        }

        List<Hike> hikes = null;

        try {
            if (entityManager != null && entityManager.isOpen()) {
                Query query = entityManager.createQuery("SELECT h FROM Hike h WHERE LOWER(h.title) LIKE LOWER(:title)");
                query.setParameter("title", "%" + title + "%");
                hikes = query.getResultList();

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

        return hikes;
    }

    public List<Hike> search(String title,int durationLow,int durationHigh, int strengthLow,
                             int strengthHigh, int staminaLow,int staminaHigh,
                             int experienceLow, int experienceHigh, int landscapeLow,
                             int landscapeHigh, int distanceLow, int distanceHigh,
                             int altitudeLow, int altitudeHigh, int month) {
        EntityManager entityManager = null;
        try {
            entityManager = getEntityManager();
        } catch (Exception f){
            System.out.println("no entityManager");
        }

        List<Hike> hikes = null;

        try {
            if (entityManager != null && entityManager.isOpen()) {
                String[] months = {"january",
                        "february",
                        "march",
                        "april",
                        "may",
                        "june",
                        "july",
                        "august",
                        "september",
                        "october",
                        "november",
                        "december"};
                CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
                CriteriaQuery<Hike> criteriaQuery = criteriaBuilder.createQuery(Hike.class);
                Root<Hike> root = criteriaQuery.from(Hike.class);

                Predicate titlePredicate = criteriaBuilder.like(
                        criteriaBuilder.lower(root.get("title")), "%" + title.toLowerCase() + "%"
                );
                Predicate durationPredicate = criteriaBuilder.between(
                        root.get("duration"), durationLow, durationHigh
                );
                Predicate strengthPredicate = criteriaBuilder.between(
                        root.get("strength"), strengthLow, strengthHigh
                );
                Predicate staminaPredicate = criteriaBuilder.between(
                        root.get("stamina"), staminaLow, staminaHigh
                );
                Predicate experiencePredicate = criteriaBuilder.between(
                        root.get("experience"), experienceLow, experienceHigh
                );
                Predicate landscapePredicate = criteriaBuilder.between(
                        root.get("landscape"), landscapeLow, landscapeHigh
                );
                Predicate distancePredicate = criteriaBuilder.between(
                        root.get("distance"), distanceLow, distanceHigh
                );
                Predicate altitudePredicate = criteriaBuilder.between(
                        root.get("altitude"), altitudeLow, altitudeHigh
                );
                List<Predicate> monthPredicatesArray = new ArrayList<>();
                System.out.println("Month value");
                System.out.println(month);
                if (month != 0) {
                    for (int i = 0; i < 12; i++) {
                        int mask = 1 << i;
                        if ((month & mask) != 0) {
                            String monthFieldName = months[i];
                            monthPredicatesArray.add(criteriaBuilder.equal(root.get(monthFieldName), true));
                            System.out.println("Month");
                            System.out.println(criteriaBuilder.equal(root.get(monthFieldName), true));
                        }
                    }
                    Predicate monthPredicate = criteriaBuilder.and(monthPredicatesArray.toArray(new Predicate[0]));
                    criteriaQuery.where(
                            criteriaBuilder.and(
                                    titlePredicate,
                                    durationPredicate,
                                    strengthPredicate,
                                    staminaPredicate,
                                    experiencePredicate,
                                    landscapePredicate,
                                    distancePredicate,
                                    altitudePredicate,
                                    monthPredicate
                            )
                    );
                }else{
                criteriaQuery.where(
                        criteriaBuilder.and(
                                titlePredicate,
                                durationPredicate,
                                strengthPredicate,
                                staminaPredicate,
                                experiencePredicate,
                                landscapePredicate,
                                distancePredicate,
                                altitudePredicate
                        )
                    );
                }
                TypedQuery<Hike> typedQuery = entityManager.createQuery(criteriaQuery);
                hikes = typedQuery.getResultList();

                Query query = entityManager.createQuery("" +
                                "SELECT h FROM Hike h WHERE LOWER(h.title) LIKE LOWER(:title)" +
                                "AND h.duration > (:durationLow) AND h.duration < (:durationHigh)" +
                                "AND h.strength > (:strengthLow) AND h.strength < (:strengthHigh)" +
                                "AND h.stamina >(:staminaLow) AND h.stamina < (:staminaHigh)" +
                                "AND h.experience > (:experienceLow) AND h.strength < (:experienceHigh)" +
                                "AND h.landscape > (:landscapeLow) AND h.landscape < (:landscapeHigh)" +
                                "AND h.distance > (:distanceLow) AND h.distance < (:distanceHigh)" +
                                "AND h.altitude > (:altitudeLow) AND h.altitude < (:altitudeHigh)");
                query.setParameter("title", "%" + title + "%");
                query.setParameter("durationLow", durationLow);
                query.setParameter("durationHigh", durationHigh);
                query.setParameter("strengthLow", strengthLow);
                query.setParameter("strengthHigh", strengthHigh);
                query.setParameter("staminaLow", staminaLow);
                query.setParameter("staminaHigh", staminaHigh);
                query.setParameter("experienceLow", experienceLow);
                query.setParameter("experienceHigh", experienceHigh);
                query.setParameter("landscapeLow", landscapeLow);
                query.setParameter("landscapeHigh", landscapeHigh);
                query.setParameter("distanceLow", distanceLow);
                query.setParameter("distanceHigh", distanceHigh);
                query.setParameter("altitudeLow", altitudeLow);
                query.setParameter("altitudeHigh", altitudeHigh);


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

        return hikes;
    }
}


