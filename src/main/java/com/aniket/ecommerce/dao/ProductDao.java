package com.aniket.ecommerce.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.Query;
import javax.persistence.TypedQuery;

import com.aniket.ecommerce.entity.Merchant;
import com.aniket.ecommerce.entity.Product;

public class ProductDao {

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

    public void openConnection() {
        entityManagerFactory = Persistence.createEntityManagerFactory("ecommerce");
        entityManager = entityManagerFactory.createEntityManager();
        entityTransaction = entityManager.getTransaction();
    }

    public void closeConnection() {
        if (entityManager != null)
            entityManager.close();
        if (entityManagerFactory != null)
            entityManagerFactory.close();
        if (entityTransaction != null && entityTransaction.isActive())
            entityTransaction.rollback();
    }

    // ─────────────────────────────────────────────────────────────
    // SAVE / UPDATE PRODUCT
    // ─────────────────────────────────────────────────────────────
    public Product saveProduct(Product product) {
        openConnection();
        try {
            entityTransaction.begin();
            
            if (product.getId() == 0) {
                // ✅ NEW product — persist gives back real generated ID
                entityManager.persist(product);
                entityManager.flush(); // forces INSERT immediately
            } else {
                // ✅ EXISTING product — merge for updates
                product = (Product) entityManager.merge(product);
            }
            
            entityTransaction.commit();
            System.out.println("✅ DAO returning ID = " + product.getId()); // should NOT be 0
            return product;
            
        } catch (Exception e) {
            if (entityTransaction.isActive()) entityTransaction.rollback();
            throw e;
        } finally {
            closeConnection();
        }
    }

    // ─────────────────────────────────────────────────────────────
    // FIND ALL PRODUCTS
    // ─────────────────────────────────────────────────────────────
    public List<Product> findAllProduct() {
        openConnection();
        try {
            Query query = entityManager.createQuery("SELECT p FROM Product p");
            return query.getResultList();
        } finally {
            closeConnection();
        }
    }

    public List<Product> getAllProducts() {
        return findAllProduct(); // alias kept for compatibility
    }

    // ─────────────────────────────────────────────────────────────
    // FIND PRODUCT BY ID
    // ─────────────────────────────────────────────────────────────
    public Product findProductById(Integer productId) {
        openConnection();
        try {
            return entityManager.find(Product.class, productId);
        } finally {
            closeConnection();
        }
    }

    // ─────────────────────────────────────────────────────────────
    // FIND PRODUCTS BY MERCHANT
    // ─────────────────────────────────────────────────────────────
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

    public Product findByProductNameAndMerchant(String productName, Merchant merchant) {
        openConnection();
        try {
            return entityManager.createQuery(
                "SELECT p FROM Product p WHERE p.productName = :productName AND p.merchant = :merchant",
                Product.class)
                .setParameter("productName", productName)
                .setParameter("merchant", merchant)
                .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            closeConnection();
        }
    }

    // ─────────────────────────────────────────────────────────────
    // CATEGORY QUERIES
    // ─────────────────────────────────────────────────────────────
    public List<Product> findByCategory(String category) {
        openConnection();
        try {
            return entityManager.createQuery(
                "SELECT p FROM Product p WHERE p.category = :category", Product.class)
                .setParameter("category", category)
                .getResultList();
        } finally {
            closeConnection();
        }
    }

    public List<String> findAllDistinctCategories() {
        openConnection();
        try {
            return entityManager.createQuery(
                "SELECT DISTINCT p.category FROM Product p", String.class)
                .getResultList();
        } finally {
            closeConnection();
        }
    }

    public Long countByCategory(String category) {
        openConnection();
        try {
            return (Long) entityManager.createQuery(
                "SELECT COUNT(p) FROM Product p WHERE p.category = :category")
                .setParameter("category", category)
                .getSingleResult();
        } finally {
            closeConnection();
        }
    }

    // ─────────────────────────────────────────────────────────────
    // STOCK QUANTITY — merchant updates stock
    // ─────────────────────────────────────────────────────────────
    /**
     * Reduce stock after a purchase.
     * Called from PaymentController during checkout.
     */
    public void reduceStock(int productId, int quantitySold) {
        openConnection();
        try {
            entityTransaction.begin();
            entityManager.createQuery(
                "UPDATE Product p SET p.stockQuantity = p.stockQuantity - :qty " +
                "WHERE p.id = :id AND p.stockQuantity >= :qty")
                .setParameter("qty", quantitySold)
                .setParameter("id", productId)
                .executeUpdate();
            entityTransaction.commit();
        } catch (Exception e) {
            if (entityTransaction.isActive()) entityTransaction.rollback();
            throw e;
        } finally {
            closeConnection();
        }
    }

 // ✅ ADD this new method — only updates, never inserts
    public void updateImagePath(int productId, String imageUrl) {
        if (productId == 0) {
            System.out.println("❌ updateImagePath called with id=0 — skipping!");
            return;
        }
        openConnection();
        try {
            entityTransaction.begin();
            int rows = entityManager.createQuery(
                "UPDATE Product p SET p.imagePath = :imageUrl WHERE p.id = :id")
                .setParameter("imageUrl", imageUrl)
                .setParameter("id", productId)
                .executeUpdate();
            entityTransaction.commit();
            System.out.println("✅ Updated " + rows + " rows with image URL for id=" + productId);
        } catch (Exception e) {
            if (entityTransaction.isActive()) entityTransaction.rollback();
            throw e;
        } finally {
            closeConnection();
        }
    }
}