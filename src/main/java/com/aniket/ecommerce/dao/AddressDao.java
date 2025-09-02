package com.aniket.ecommerce.dao;

import com.aniket.ecommerce.entity.Address;
import com.aniket.ecommerce.entity.User;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;
import java.util.Optional;

public class AddressDao {
    
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
    
    private void openConnection() {
        entityManagerFactory = Persistence.createEntityManagerFactory("ecommerce");
        entityManager = entityManagerFactory.createEntityManager();
        entityTransaction = entityManager.getTransaction();
    }
    
    public void closeConnection() {
        if (entityManagerFactory != null)
            entityManagerFactory.close();
        if (entityManager != null)
            entityManager.close();
        if (entityTransaction != null && entityTransaction.isActive()) {
            entityTransaction.rollback();
        }
    }
    
    public Address saveAddress(Address address) {
        openConnection();
        try {
            entityTransaction.begin();
            Address savedAddress = entityManager.merge(address);
            entityTransaction.commit();
            return savedAddress;
        } catch (Exception e) {
            if (entityTransaction.isActive()) {
                entityTransaction.rollback();
            }
            throw new RuntimeException("Error saving address: " + e.getMessage(), e);
        } finally {
            closeConnection();
        }
    }
    
    public Address getAddressById(int id) {
        openConnection();
        try {
            Address address = entityManager.find(Address.class, id);
            return address;
        } finally {
            closeConnection();
        }
    }
    
    public List<Address> getAddressesByUser(User user) {
        openConnection();
        try {
            CriteriaBuilder builder = entityManager.getCriteriaBuilder();
            CriteriaQuery<Address> criteria = builder.createQuery(Address.class);
            Root<Address> root = criteria.from(Address.class);
            
            criteria.select(root).where(builder.equal(root.get("user"), user));
            
            return entityManager.createQuery(criteria).getResultList();
        } finally {
            closeConnection();
        }
    }
    
    public List<Address> getAddressesByUserId(int i) {
        openConnection();
        try {
            CriteriaBuilder builder = entityManager.getCriteriaBuilder();
            CriteriaQuery<Address> criteria = builder.createQuery(Address.class);
            Root<Address> root = criteria.from(Address.class);
            
            criteria.select(root).where(builder.equal(root.get("user").get("id"), i));
            
            return entityManager.createQuery(criteria).getResultList();
        } finally {
            closeConnection();
        }
    }
    
    public Optional<Address> getDefaultAddress(User user) {
        openConnection();
        try {
            CriteriaBuilder builder = entityManager.getCriteriaBuilder();
            CriteriaQuery<Address> criteria = builder.createQuery(Address.class);
            Root<Address> root = criteria.from(Address.class);
            
            criteria.select(root)
                   .where(builder.and(
                       builder.equal(root.get("user"), user),
                       builder.equal(root.get("isDefault"), true)
                   ));
            
            List<Address> results = entityManager.createQuery(criteria).getResultList();
            return results.isEmpty() ? Optional.empty() : Optional.of(results.get(0));
        } finally {
            closeConnection();
        }
    }
    
    public void unsetDefaultAddresses(User user) {
        openConnection();
        try {
            entityTransaction.begin();
            
            // Use native SQL query instead of JPQL
            String sql = "UPDATE address SET isDefault = 0 WHERE user_id = :userId AND isDefault = 1";
            javax.persistence.Query query = entityManager.createNativeQuery(sql);
            query.setParameter("userId", user.getId());
            query.executeUpdate();
            
            entityTransaction.commit();
        } catch (Exception e) {
            if (entityTransaction.isActive()) {
                entityTransaction.rollback();
            }
            throw new RuntimeException("Error unsetting default addresses: " + e.getMessage(), e);
        } finally {
            closeConnection();
        }
    }
    
    public void deleteAddress(Long id) {
        openConnection();
        try {
            entityTransaction.begin();
            
            Address address = entityManager.find(Address.class, id);
            if (address != null) {
                entityManager.remove(address);
            }
            
            entityTransaction.commit();
        } catch (Exception e) {
            if (entityTransaction.isActive()) {
                entityTransaction.rollback();
            }
            throw new RuntimeException("Error deleting address: " + e.getMessage(), e);
        } finally {
            closeConnection();
        }
    }
    
    public void deleteAddress(Address address) {
        openConnection();
        try {
            entityTransaction.begin();
            
            Address managedAddress = entityManager.merge(address);
            entityManager.remove(managedAddress);
            
            entityTransaction.commit();
        } catch (Exception e) {
            if (entityTransaction.isActive()) {
                entityTransaction.rollback();
            }
            throw new RuntimeException("Error deleting address: " + e.getMessage(), e);
        } finally {
            closeConnection();
        }
    }
    
    public long countAddressesByUser(User user) {
        openConnection();
        try {
            CriteriaBuilder builder = entityManager.getCriteriaBuilder();
            CriteriaQuery<Long> criteria = builder.createQuery(Long.class);
            Root<Address> root = criteria.from(Address.class);
            
            criteria.select(builder.count(root)).where(builder.equal(root.get("user"), user));
            
            return entityManager.createQuery(criteria).getSingleResult();
        } finally {
            closeConnection();
        }
    }
    
    // Additional helper method to get addresses with eager loading
    public List<Address> getAddressesByUserWithEagerLoading(User user) {
        openConnection();
        try {
            String jpql = "SELECT a FROM Address a JOIN FETCH a.user WHERE a.user = :user";
            TypedQuery<Address> query = entityManager.createQuery(jpql, Address.class);
            query.setParameter("user", user);
            return query.getResultList();
        } finally {
            closeConnection();
        }
    }
}