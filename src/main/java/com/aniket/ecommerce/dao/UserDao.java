package com.aniket.ecommerce.dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;

import com.aniket.ecommerce.entity.User;

public class UserDao {

    private EntityManagerFactory emf;
    private EntityManager entityManager;
    private EntityTransaction entityTransaction;

    public UserDao() {
        try {
            // Initialize EMF for this DAO instance
            emf = Persistence.createEntityManagerFactory("ecommerce");
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Could not create EntityManagerFactory for UserDao", e);
        }
    }

    private void openConnection() {
        try {
            entityManager = emf.createEntityManager();
            entityTransaction = entityManager.getTransaction();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Could not create EntityManager for UserDao", e);
        }
    }

    private void closeConnection() {
        if (entityManager != null && entityManager.isOpen()) {
            entityManager.close();
        }
    }

    public void close() {
        closeConnection();
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
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
            return user;
        } catch (Exception e) {
            if (entityTransaction != null && entityTransaction.isActive()) {
                entityTransaction.rollback();
            }
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

            if (user != null && user.getPassword().equals(password)) {
                return user;
            }
            return null;
        } catch (Exception e) {
            return null;
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