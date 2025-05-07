package com.aniket.ecommerce.dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;

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

	public Product saveProduct(Product product) {
		// TODO Auto-generated method stub
		openConnection();
		entityTransaction.begin();
		entityManager.persist(product);
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
}
