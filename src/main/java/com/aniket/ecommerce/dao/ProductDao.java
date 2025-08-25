package com.aniket.ecommerce.dao;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.Query;

import com.aniket.ecommerce.entity.Merchant;
import com.aniket.ecommerce.entity.Product;

public class ProductDao {

    private EntityManagerFactory emf;
    private EntityManager entityManager;
    private EntityTransaction entityTransaction;

    public ProductDao() {
        try {
            // Initialize EMF for this DAO instance
            emf = Persistence.createEntityManagerFactory("ecommerce");
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Could not create EntityManagerFactory for ProductDao", e);
        }
    }

    // ---------- Utility methods ----------
    public void openConnection() {
        try {
            entityManager = emf.createEntityManager();
            entityTransaction = entityManager.getTransaction();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Could not create EntityManager for ProductDao", e);
        }
    }

    public void closeConnection() {
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

    // ---------- CRUD Methods ----------

    public Product saveProduct(Product product) {
        openConnection();
        try {
            entityTransaction.begin();
            entityManager.persist(product);
            entityTransaction.commit();
            return product;
        } catch (Exception e) {
            if (entityTransaction.isActive()) entityTransaction.rollback();
            throw e;
        } finally {
            closeConnection();
        }
    }

    public List<Product> findAllProduct() {
        openConnection();
        try {
            Query query = entityManager.createQuery("SELECT p FROM Product p");
            return query.getResultList();
        } finally {
            closeConnection();
        }
    }

    public List<Product> getProductsByMerchantId(int merchantId) {
        openConnection();
        try {
            return entityManager.createQuery(
                    "SELECT p FROM Product p WHERE p.merchant.id = :merchantId", Product.class)
                    .setParameter("merchantId", merchantId)
                    .getResultList();
        } finally {
            closeConnection();
        }
    }

    public Product findProductById(Integer productId) {
        openConnection();
        try {
            return entityManager.find(Product.class, productId);
        } finally {
            closeConnection();
        }
    }

    public Product findByProductNameAndMerchant(String productName, Merchant merchant) {
        openConnection();
        try {
            String jpql = "SELECT p FROM Product p WHERE p.productName = :productName AND p.merchant = :merchant";
            return entityManager.createQuery(jpql, Product.class)
                    .setParameter("productName", productName)
                    .setParameter("merchant", merchant)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            closeConnection();
        }
    }

    public List<Product> findByCategory(String category) {
        openConnection();
        try {
            Query query = entityManager.createQuery(
                    "SELECT p FROM Product p WHERE p.category = :category", Product.class);
            query.setParameter("category", category);
            return query.getResultList();
        } finally {
            closeConnection();
        }
    }

    public List<String> findAllDistinctCategories() {
        openConnection();
        try {
            Query query = entityManager.createQuery(
                    "SELECT DISTINCT p.category FROM Product p", String.class);
            return query.getResultList();
        } finally {
            closeConnection();
        }
    }

    public Long countByCategory(String category) {
        openConnection();
        try {
            Query query = entityManager.createQuery(
                    "SELECT COUNT(p) FROM Product p WHERE p.category = :category", Long.class);
            query.setParameter("category", category);
            return (Long) query.getSingleResult();
        } finally {
            closeConnection();
        }
    }

    public List<Product> getAllProducts() {
        openConnection();
        try {
            Query query = entityManager.createQuery("SELECT p FROM Product p", Product.class);
            return query.getResultList();
        } finally {
            closeConnection();
        }
    }
}