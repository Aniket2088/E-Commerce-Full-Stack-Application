package com.aniket.ecommerce.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;

import com.aniket.ecommerce.entity.Order;
import com.aniket.ecommerce.entity.User;

public class OrderDao {

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
    // SAVE ORDER (cascades to OrderItems automatically via CascadeType.ALL)
    // ─────────────────────────────────────────────────────────────
    public Order save(Order order) {
        openConnection();
        try {
            entityTransaction.begin();
            Order merged = entityManager.merge(order);
            entityTransaction.commit();
            return merged;
        } catch (Exception e) {
            if (entityTransaction.isActive()) entityTransaction.rollback();
            e.printStackTrace();
            throw e;
        } finally {
            closeConnection();
        }
    }

    // ─────────────────────────────────────────────────────────────
    // FIND ALL ORDERS FOR A USER  (newest first)
    // ✅ JOIN FETCH forces Hibernate to load orderItems + product
    //    in ONE query while the session is still open.
    //    DISTINCT prevents duplicate Order rows from the JOIN.
    // ─────────────────────────────────────────────────────────────
    public List<Order> findByUser(User user) {
        openConnection();
        try {
            TypedQuery<Order> query = entityManager.createQuery(
                "SELECT DISTINCT o FROM Order o " +
                "LEFT JOIN FETCH o.orderItems oi " +
                "LEFT JOIN FETCH oi.product p " +
                "LEFT JOIN FETCH p.merchant " +
                "WHERE o.user.id = :userId " +
                "ORDER BY o.orderDate DESC",
                Order.class);
            query.setParameter("userId", user.getId());
            return query.getResultList();
        } finally {
            closeConnection();
        }
    }

    // ─────────────────────────────────────────────────────────────
    // FIND SINGLE ORDER BY ID  (used by InvoiceController)
    // ✅ JOIN FETCH loads orderItems + product eagerly so the
    //    session can safely close before the PDF is built.
    // ─────────────────────────────────────────────────────────────
    public Order findById(int id) {
        openConnection();
        try {
            TypedQuery<Order> query = entityManager.createQuery(
                "SELECT DISTINCT o FROM Order o " +
                "LEFT JOIN FETCH o.orderItems oi " +
                "LEFT JOIN FETCH oi.product p " +
                "LEFT JOIN FETCH p.merchant " +
                "WHERE o.id = :id",
                Order.class);
            query.setParameter("id", id);
            List<Order> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            closeConnection();
        }
    }
}