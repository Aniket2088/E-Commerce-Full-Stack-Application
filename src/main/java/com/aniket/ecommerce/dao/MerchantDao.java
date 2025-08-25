package com.aniket.ecommerce.dao;

import javax.persistence.*;
import com.aniket.ecommerce.entity.Merchant;

public class MerchantDao {

    private EntityManagerFactory emf;

    public MerchantDao() {
        try {
            // Initialize EMF for this DAO instance
            emf = Persistence.createEntityManagerFactory("ecommerce");
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Could not create EntityManagerFactory for MerchantDao", e);
        }
    }

    // Save Merchant
    public Merchant saveMerchant(Merchant merchant) {
        EntityManager entityManager = emf.createEntityManager();
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
        EntityManager entityManager = emf.createEntityManager();
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
        EntityManager entityManager = emf.createEntityManager();
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
        EntityManager entityManager = emf.createEntityManager();
        try {
            return entityManager.find(Merchant.class, merchantId);
        } finally {
            entityManager.close();
        }
    }

    // Close Factory (when application shuts down)
    public void close() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}