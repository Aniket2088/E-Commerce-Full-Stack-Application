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
import com.aniket.ecommerce.entity.User;


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

	public Product saveProduct(Product product) {
		// TODO Auto-generated method stub
		openConnection();
		entityTransaction.begin();
		entityManager.merge(product);
		entityTransaction.commit();
		
		return product;
		
	}

	public void openConnection()
	{
		entityManagerFactory=Persistence.createEntityManagerFactory("ecommerce");
		entityManager=entityManagerFactory.createEntityManager();
		entityTransaction=entityManager.getTransaction();
	}
	
	public void closeConnection()
	{
		if(entityManagerFactory!=null)
			entityManagerFactory.close();
		if(entityManager!=null)
			entityManager.close();
		if(entityTransaction.isActive())
		{
			if(entityTransaction!=null)
				entityTransaction.rollback();
		}
	}

	public List<Product> findAllProduct() {
		// TODO Auto-generated method stub
		openConnection();
		Query query = entityManager.createQuery("select products from Product products");
		List<Product> products = query.getResultList();
		closeConnection();
		return products;
		
		
	}

	public List<Product> getProductsByMerchantId(int merchantId) {
		openConnection();
	    return entityManager.createQuery("SELECT p FROM Product p WHERE p.merchant.id = :merchantId", Product.class)
	                        .setParameter("merchantId", merchantId)
	                        .getResultList();
	}

	public Product findProductById(Integer productId) {
		// TODO Auto-generated method stub
		openConnection();
		Product product = entityManager.find(Product.class, productId);
		
		return product;
	}

	public Product findByProductNameAndMerchant(String productName, Merchant merchant) {
	    try {
	        String jpql = "SELECT p FROM Product p WHERE p.productName = :productName AND p.merchant = :merchant";
	        return entityManager.createQuery(jpql, Product.class)
	                .setParameter("productName", productName)
	                .setParameter("merchant", merchant)
	                .getSingleResult();
	    } catch (NoResultException e) {
	        return null;
	    }
	}

	// Add these methods to your ProductDao class
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

	public List<Product> findByPaymentStatusTrue(User user) {
	    boolean status = true;
	    openConnection();
	    try {
	        Query query = entityManager.createQuery(
	            "SELECT p FROM Product p WHERE p.paymentStatus = :status AND p.user = :user", Product.class);
	        query.setParameter("status", status);
	        query.setParameter("user", user);
	        return query.getResultList();
	    } finally {
	        closeConnection();
	    }
	}
	
}
