package com.aniket.ecommerce.dao;

import java.util.List;


import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.Query;
import javax.persistence.TypedQuery;

import org.apache.taglibs.standard.lang.jstl.Logger;

import com.aniket.ecommerce.entity.Merchant;
import com.aniket.ecommerce.entity.Product;

public class MerchantDao {
	
	private EntityManagerFactory entityManagerFactory;
	private EntityManager entityManager;
	private EntityTransaction entityTransaction;
	
	static {
	    try {
	        Class.forName("com.mysql.cj.jdbc.Driver");
	    } catch (ClassNotFoundException e) {
	        e.printStackTrace();
	    }
	}

	public Merchant saveMerchant(Merchant merchant) {
		// TODO Auto-generated method stub
		
		openConnection();
		entityTransaction.begin();
		entityManager.persist(merchant);
		entityTransaction.commit();
		
		return merchant;
		
	}

	private void openConnection()
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

	public Merchant findByEmail(String email) {
	    try {
	        Query query = entityManager.createQuery("SELECT m FROM Merchant m WHERE m.email = :email");
	        query.setParameter("email", email);
	        return (Merchant) query.getSingleResult();
	    } catch (NoResultException e) {
	        return null; // Return null if no merchant found with this email
	    } catch (Exception e) {
	        // Log the exception
	        e.printStackTrace();
	        throw new RuntimeException("Error finding merchant by email", e);
	    }
	}

	public Merchant authenticate(String email, String password) {
	    try {
	        // 1. Find merchant by email
	        TypedQuery<Merchant> query = entityManager.createQuery(
	            "SELECT m FROM Merchant m WHERE m.email = :email", Merchant.class);
	        query.setParameter("email", email);
	        
	        Merchant merchant = query.getSingleResult();
	        
	        // 2. Verify password (plain text comparison - NOT for production)
	        if (merchant != null && merchant.getPassword().equals(password)) {
	            return merchant;
	        }
	        
	        // 3. If password doesn't match
	        return null;
	        
	    } catch (NoResultException e) {
	        // No merchant found with this email
	        return null;
	    } catch (Exception e) {
	        // Log the error
	        
	        throw new RuntimeException("Authentication failed", e);
	    }
	}
}
