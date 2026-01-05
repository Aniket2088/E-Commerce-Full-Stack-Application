package com.aniket.ecommerce.dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;

import org.hibernate.Hibernate;

import com.aniket.ecommerce.entity.Merchant;
import com.aniket.ecommerce.entity.User;

public class UserDao {
	static {
	    try {
	        Class.forName("com.mysql.cj.jdbc.Driver");
	    } catch (ClassNotFoundException e) {
	        e.printStackTrace();
	    }
	}
	private EntityManager entityManager;
	private EntityManagerFactory entityManagerFactory;
	private EntityTransaction entityTransaction;
	
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

	public User signUpUser(String firstName, String lastName, String email, String password) {
		User user = new User();
		user.setName(firstName+" "+lastName);
		user.setEmail(email);
		user.setPassword(password);
		openConnection();
		entityTransaction.begin();
		entityManager.persist(user);
		entityTransaction.commit();
		closeConnection();
		return null;
	}

	public User  loginUser(String email, String password) {
		openConnection();
        TypedQuery<User> query = entityManager.createQuery(
            "SELECT m FROM User m WHERE m.email = :email", User.class);
        query.setParameter("email", email);
        
        User user = query.getSingleResult();
       
        closeConnection();
        // 2. Verify password (plain text comparison - NOT for production)
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
			
        return null;
		
	}

	public void save(User user) {
	    openConnection();
	    try {
	        entityTransaction.begin();
	        entityManager.merge(user);
	        entityTransaction.commit();
	    } catch (Exception e) {
	        if (entityTransaction != null && entityTransaction.isActive()) {
	            entityTransaction.rollback();
	        }
	        throw e;
	    } finally {
	        closeConnection();
	    }
	}


	public User findById(int id) {
		// TODO Auto-generated method stub
		openConnection();
User user = entityManager.find(User.class, id);
closeConnection();
		return user;
	}
	
	public boolean deleteUser(User user) {
		 try {
			 openConnection();
		        // Get a managed instance of the user
		        User managedUser = entityManager.merge(user);
		        
		        // Clear any relationships if needed
		        managedUser.getCartItems().clear();
		        
		        // Now remove the managed entity
		        entityManager.remove(managedUser);
		        closeConnection();
		        return true;
		    } catch (Exception e) {
		        // Log the error
		        e.printStackTrace();
		        return false;
		    }
		
	}
}
