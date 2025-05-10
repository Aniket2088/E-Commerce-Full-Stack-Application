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
}
