package com.aniket.ecommerce.dao;

import javax.persistence.*;
import com.aniket.ecommerce.entity.Merchant;

public class MerchantDao {

    private static final EntityManagerFactory entityManagerFactory;

    // Load PostgreSQL Driver once
    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        entityManagerFactory = Persistence.createEntityManagerFactory("ecommerce");
    }

    // Save Merchant
    public Merchant saveMerchant(Merchant merchant) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            entityManager.persist(merchant);
            transaction.commit();
            return merchant;
        } catch (Exception e) {
            if (transaction.isActive()) transaction.rollback();
            throw e;
        } finally {
            entityManager.close();
        }
    }

    // Find by Email
    public Merchant findByEmail(String email) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            TypedQuery<Merchant> query = entityManager.createQuery(
                "SELECT m FROM Merchant m WHERE m.email = :email", Merchant.class);
            query.setParameter("email", email);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            entityManager.close();
        }
    }

    // Authenticate Merchant (email + password check)
    public Merchant authenticate(String email, String password) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            TypedQuery<Merchant> query = entityManager.createQuery(
                "SELECT m FROM Merchant m WHERE m.email = :email", Merchant.class);
            query.setParameter("email", email);

            Merchant merchant = query.getSingleResult();

            if (merchant != null && merchant.getPassword().equals(password)) {
                return merchant;
            }
            return null;
        } catch (NoResultException e) {
            return null;
        } finally {
            entityManager.close();
        }
    }

    // Find by Merchant ID
    public Merchant findMerchantById(int merchantId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.find(Merchant.class, merchantId);
        } finally {
            entityManager.close();
        }
    }

    // Close Factory (when application shuts down)
    public static void closeFactory() {
        if (entityManagerFactory != null && entityManagerFactory.isOpen()) {
            entityManagerFactory.close();
        }
    }
}
