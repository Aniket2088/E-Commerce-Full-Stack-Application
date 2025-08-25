package com.aniket.ecommerce.dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;

import com.aniket.ecommerce.entity.User;

public class UserDao {

    // ✅ Create only ONE EntityManagerFactory (singleton)
    private static final EntityManagerFactory emf = 
            Persistence.createEntityManagerFactory("ecommerce");

    private EntityManager entityManager;
    private EntityTransaction entityTransaction;

    private void openConnection() {
        entityManager = emf.createEntityManager();
        entityTransaction = entityManager.getTransaction();
    }

    private void closeConnection() {
        if (entityManager != null && entityManager.isOpen()) {
            if (entityTransaction != null && entityTransaction.isActive()) {
                entityTransaction.rollback();
            }
            entityManager.close();
        }
        // ❌ Do NOT close emf here → keep it open globally
    }

    public User signUpUser(String firstName, String lastName, String email, String password) {
        User user = new User();
        user.setName(firstName + " " + lastName);
        user.setEmail(email);
        user.setPassword(password);

        openConnection();
        try {
            entityTransaction.begin();
            entityManager.persist(user);
            entityTransaction.commit();
            return user; // return the saved user
        } catch (Exception e) {
            if (entityTransaction.isActive()) entityTransaction.rollback();
            throw e;
        } finally {
            closeConnection();
        }
    }

    public User loginUser(String email, String password) {
        openConnection();
        try {
            TypedQuery<User> query = entityManager.createQuery(
                "SELECT u FROM User u WHERE u.email = :email", User.class);
            query.setParameter("email", email);

            User user = query.getSingleResult();

            // Verify password (plain text check — use hashing in production)
            if (user != null && user.getPassword().equals(password)) {
                return user;
            }
            return null;
        } catch (Exception e) {
            return null; // user not found or wrong login
        } finally {
            closeConnection();
        }
    }

    public void save(User user) {
        openConnection();
        try {
            entityTransaction.begin();
            entityManager.merge(user);
            entityTransaction.commit();
        } catch (Exception e) {
            if (entityTransaction.isActive()) entityTransaction.rollback();
            throw e;
        } finally {
            closeConnection();
        }
    }

    public User findById(int id) {
        openConnection();
        try {
            return entityManager.find(User.class, id);
        } finally {
            closeConnection();
        }
    }

    public boolean deleteUser(User user) {
        openConnection();
        try {
            entityTransaction.begin();
            User managedUser = entityManager.merge(user);

            // clear cart items if needed (avoid constraint issues)
            if (managedUser.getCartItems() != null) {
                managedUser.getCartItems().clear();
            }

            entityManager.remove(managedUser);
            entityTransaction.commit();
            return true;
        } catch (Exception e) {
            if (entityTransaction.isActive()) entityTransaction.rollback();
            e.printStackTrace();
            return false;
        } finally {
            closeConnection();
        }
    }
}
