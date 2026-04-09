package com.aniket.ecommerce.dao;

import java.util.List;
import java.util.Optional;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;

import com.aniket.ecommerce.entity.CartItem;
import com.aniket.ecommerce.entity.Product;
import com.aniket.ecommerce.entity.User;

public class CartItemDao {

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private EntityManagerFactory entityManagerFactory;
    private EntityManager entityManager;
    private EntityTransaction entityTransaction;

    private void openConnection() {
        entityManagerFactory = Persistence.createEntityManagerFactory("ecommerce");
        entityManager = entityManagerFactory.createEntityManager();
        entityTransaction = entityManager.getTransaction();
    }

    private void closeConnection() {
        if (entityManager != null)
            entityManager.close();
        if (entityManagerFactory != null)
            entityManagerFactory.close();
        if (entityTransaction != null && entityTransaction.isActive())
            entityTransaction.rollback();
    }

    // ─────────────────────────────────────────────────────────────
    // SAVE (insert or update)
    // ─────────────────────────────────────────────────────────────
    public CartItem save(CartItem cartItem) {
        openConnection();
        try {
            entityTransaction.begin();
            CartItem merged = entityManager.merge(cartItem);
            entityTransaction.commit();
            return merged;
        } catch (Exception e) {
            if (entityTransaction.isActive()) entityTransaction.rollback();
            throw e;
        } finally {
            closeConnection();
        }
    }

    // ─────────────────────────────────────────────────────────────
    // FIND ALL CART ITEMS FOR A USER
    // ─────────────────────────────────────────────────────────────
    public List<CartItem> findByUser(User user) {
        openConnection();
        try {
            TypedQuery<CartItem> query = entityManager.createQuery(
                "SELECT c FROM CartItem c WHERE c.user.id = :userId", CartItem.class);
            query.setParameter("userId", user.getId());
            return query.getResultList();
        } finally {
            closeConnection();
        }
    }

    // ─────────────────────────────────────────────────────────────
    // FIND ONE CART ITEM BY USER + PRODUCT (to check duplicate)
    // ─────────────────────────────────────────────────────────────
    public Optional<CartItem> findByUserAndProduct(User user, Product product) {
        openConnection();
        try {
            TypedQuery<CartItem> query = entityManager.createQuery(
                "SELECT c FROM CartItem c WHERE c.user.id = :userId AND c.product.id = :productId",
                CartItem.class);
            query.setParameter("userId", user.getId());
            query.setParameter("productId", product.getId());
            CartItem result = query.getSingleResult();
            return Optional.of(result);
        } catch (NoResultException e) {
            return Optional.empty();
        } finally {
            closeConnection();
        }
    }

    // ─────────────────────────────────────────────────────────────
    // DELETE A SINGLE CART ITEM
    // ─────────────────────────────────────────────────────────────
    public void delete(CartItem cartItem) {
        openConnection();
        try {
            entityTransaction.begin();
            CartItem managed = entityManager.merge(cartItem);
            entityManager.remove(managed);
            entityTransaction.commit();
        } catch (Exception e) {
            if (entityTransaction.isActive()) entityTransaction.rollback();
            throw e;
        } finally {
            closeConnection();
        }
    }

    // ─────────────────────────────────────────────────────────────
    // DELETE ALL CART ITEMS FOR A USER (clear cart)
    // ─────────────────────────────────────────────────────────────
    public void deleteAllByUser(User user) {
        openConnection();
        try {
            entityTransaction.begin();
            entityManager.createQuery(
                "DELETE FROM CartItem c WHERE c.user.id = :userId")
                .setParameter("userId", user.getId())
                .executeUpdate();
            entityTransaction.commit();
        } catch (Exception e) {
            if (entityTransaction.isActive()) entityTransaction.rollback();
            throw e;
        } finally {
            closeConnection();
        }
    }
}